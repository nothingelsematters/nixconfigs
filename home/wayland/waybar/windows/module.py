import asyncio
import i3ipc
import re
import pickle

delimiter = '│'
empty = ''
ICONS = [
    ('class=Firefox', ''),
    ('class=Telegram', ''),
    ('class=Slack', ''),
    ('class=Atom', ''),
    ('class=Alacritty', ''),
    ('class=kitty', ''),
    ('class=Typora', ''),
    ('class=libreoffice*', ''),
    ('class=Evince', ''),
    ('app_id=telegramdesktop', ''),
    ('app_id=kitty', ''),
    ('app_id=evince', '')
]

def color(color, str):
    return '<span foreground="%s">%s</span>' % (color, str)

#################
# ICON RESOLVER #
#################

class Rule:
    prop = ''
    expression = ''
    value = ''

    def __init__(self, prop: str, expression: str, value: str):
        self.prop = prop
        self.expression = expression
        self.value = value


    def match(self, data: dict) -> bool:
        return data[self.prop] != None and re.match(self.expression, data[self.prop]) != None


class IconResolver:
    _rules = []
    _cache = {}


    def __init__(self, rules):
        self._rules = [self._parse_rule(rule) for rule in rules]


    def resolve(self, app):
        id = pickle.dumps(app)

        if id in self._cache:
            return self._cache[id]

        out = None

        for rule in self._rules:
            if rule.match(app):
                out = rule.value
                break

        if out is None:
            out = ""

        self._cache[id] = out

        return out


    def _parse_rule(self, rule) -> Rule:
        parts = rule[0].split('=', 1)

        prop = 'class'
        match = ''

        if len(parts) > 1:
            prop = parts[0]
            match = parts[1]
        else:
            match = parts[0]

        exp = re.escape(match).replace('\\*', '.+')

        return Rule(prop, exp, rule[1])

##################
# I3 (SWAY) PART #
##################

icon_resolver = IconResolver(ICONS)

def main():
    i3 = i3ipc.Connection()

    i3.on('workspace::focus', on_change)
    i3.on('window::focus', on_change)
    i3.on('window', on_change)

    loop = asyncio.get_event_loop()
    loop.run_in_executor(None, i3.main)
    render_apps(i3)
    loop.run_forever()


def on_change(i3, e):
    render_apps(i3)


def render_apps(i3):
    tree = i3.get_tree()
    ws = tree.workspaces()
    ws.sort(key=lambda w: w.workspace().name)
    ws = [(w.leaves(), w.name) for w in ws]

    out = []
    for apps, name in ws:
        flag = True

        out.append(["<sup> %s</sup> " % name])
        if len(apps) == 0:
            out[-1][0] += (color(focused, empty))

        for app in apps:
            wf = any(list(map(lambda x: x.focused, apps)))
            output = color(wfocused if wf else unfocused, format_entry(app))

            if flag:
                out[-1][0] += (output)
                flag = False
            else:
                out[-1].append(output)

    out = (' %s' % delimiter).join('   '.join(i) for i in out)
    print("%s%s %s" % (delimiter, out, delimiter), flush=True)


def format_entry(app):
    title = make_title(app)
    c = focused if app.focused else (urgent if app.urgent else None)
    return color(c, title) if c is not None else title


def make_title(app):
    if app.name is None:
        return ""
    icon = icon_resolver.resolve({
        'class': app.window_class,
        'name': app.name,
        'app_id': app.app_id
    })

    tg = "Telegram ("
    name = app.name
    if name[:len(tg)] == tg:
        icon = color(urgent, "%s<sub> %s</sub>" % (icon, name[len(tg):len(name)-1]))

    return icon


main()
