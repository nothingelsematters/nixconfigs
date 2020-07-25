import argparse
import asyncio
import i3ipc
import re
import pickle

delimiter = ' '
empty = ''
undefined = ''

OPTIONS = {
    'class': 'window_class',
    'name': 'name',
    'app_id': 'app_id'
}

ICONS = [
    ('class=Telegram', ''),
    ('app_id=telegramdesktop', ''),

    ('class=Slack', ''),
    ('class=Atom', ''),
    ('class=kitty', ''),
    ('class=Typora', ''),
    ('class=libreoffice.*', ''),
    ('class=Spotify', ''),
    ('class=Evince', ''),
    ('app_id=evince', ''),
    ('class=Code', ''),

    # browser
    ('name=.*(Private Browsing)', ''),
    ('name=.*YouTube.*', ''),
    ('name=.*Twitter.*', ''),
    ('name=.*Stack Overflow.*', ''),
    ('name=.*Twitch.*', ''),
    ('class=Firefox', ''),

    # terminal
    ('name=htop', ''),
    ('name=python', ''),
    ('name=.*/etc/nixos/make.sh .*', ''),
    ('name=.*@.*:.*', ''),
    ('app_id=kitty', ''),
    ('class=Alacritty', ''),

    # undefined
    ('class=.*', undefined),
    ('app_id=.*', undefined),
    ('name=.*', undefined)
]

EXTRA = [
    ('name=^Telegram \((.+)\)$', lambda matched, str: color(args.urgent, "%s<sub> %s</sub>" % (str, matched.group(1))))
]

def color(color, string):
    return '<span foreground="%s">%s</span>' % (color, string)

#################
# ICON RESOLVER #
#################

class Rule:
    prop = ''
    expression = None
    value = None

    def __init__(self, prop: str, expression, value):
        self.prop = prop
        self.expression = expression
        self.value = value

    def match(self, data: dict) -> bool:
        return self.prop in data \
            and data[self.prop] is not None \
            and self.expression.match(data[self.prop]) is not None


class Resolver:
    def __init__(self, rules):
        self._rules = [self._parse_rule(rule) for rule in rules]
        self._cache = {}

    def resolve_rules(self, app):
        appId = pickle.dumps(app)
        if appId in self._cache:
            return self._cache[appId]

        result = [rule for rule in self._rules if rule.match(app)]
        self._cache[appId] = result
        return result

    def resolve(self, app):
        resolved = self.resolve_rules(app)
        return None if len(resolved) == 0 else resolved[0].value

    def _parse_rule(self, rule) -> Rule:
        parts = rule[0].split('=', 1)
        return Rule(parts[0], re.compile(parts[1]), rule[1])

##################
# I3 (SWAY) PART #
##################

icon_resolver = Resolver(ICONS)
extra_resolver = Resolver(EXTRA)

def on_change(i3, e):
    render_apps(i3)

def render_apps(i3):
    tree = i3.get_tree()
    out = []
    for w in sorted(tree.workspaces(), key=lambda w: w.workspace().name):
        apps = w.leaves() + w.floating_nodes
        flag = True
        out.append(["<sup> %s</sup> " % w.name])

        if len(apps) == 0:
            out[-1][0] += (color(args.focused, empty))

        for app in apps:
            wf = any(list(map(lambda x: x.focused, apps)))
            output = color(args.wfocused if wf else args.unfocused, format_entry(app))

            if flag:
                out[-1][0] += output
                flag = False
            else:
                out[-1].append(output)

    out = (' %s' % delimiter).join('   '.join(i) for i in out)
    print("%s%s %s" % (delimiter, out, delimiter), flush=True)

def format_entry(app):
    title = make_title(app)
    c = args.focused if app.focused else (args.urgent if app.urgent else None)
    return color(c, title) if c is not None else title

def make_title(app):
    mapper = lambda x: getattr(app, x) if hasattr(app, x) else None
    f = lambda x: x[1] is not None
    d = dict(filter(f, zip(OPTIONS.keys(), (map(mapper, OPTIONS.values())))))

    icon = icon_resolver.resolve(d)
    for rule in extra_resolver.resolve_rules(d):
        print('action')
        icon = (rule.value)(rule.expression.match(getattr(app, OPTIONS[rule.prop])), icon)
    return icon

parser = argparse.ArgumentParser(
    description="window waybar plugin"
)
parser.add_argument(
    "--focused",
    "-f",
    type=str,
    help="rgb color: window is focused",
)
parser.add_argument(
    "--wfocused",
    "-w",
    type=str,
    help="rgb color: workspace is focused",
)
parser.add_argument(
    "--unfocused",
    "-n",
    type=str,
    help="rgb color: window is not focused",
)
parser.add_argument(
    "--urgent",
    "-u",
    type=str,
    help="rgb color: window is urgent",
)

if __name__ == "__main__":
    args = parser.parse_args()
    i3 = i3ipc.Connection()

    i3.on('workspace::focus', on_change)
    i3.on('window::focus', on_change)
    i3.on('window', on_change)

    loop = asyncio.get_event_loop()
    loop.run_in_executor(None, i3.main)
    render_apps(i3)
    loop.run_forever()
