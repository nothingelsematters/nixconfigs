import asyncio
import i3ipc
import re
import pickle

###########
# POLYBAR #
###########

def color(color, string):
    return '%%{F%s}%s%%{F-}' % (color, string)

def font(f, string):
    return '%%{T%s}%s%%{T-}' % (f, string)

def action(act, string):
    return '%%{A1:%s:}%s%%{A-}' % (act, string)

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
        return re.match(self.expression, data[self.prop]) is not None


class IconResolver:
    _rules = []
    _cache = {}


    def __init__(self, rules):
        self._rules = [self._parse_rule(rule) for rule in rules]


    def resolve(self, app):
        appId = pickle.dumps(app)

        if appId in self._cache:
            return self._cache[appId]

        for rule in self._rules:
            if rule.match(app):
                out = rule.value
                break

        self._cache[appId] = out

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

###########
# I3 PART #
###########

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
    ws = [w.leaves() for w in ws]

    out = []
    for apps in ws:
        out.append([])
        if len(apps) == 0:
            out[-1].append(color(focused, empty))

        for app in apps:
            wf = any(list(map(lambda x: x.focused, apps)))
            output = color(wfocused if wf else unfocused, format_entry(app))
            out[-1].append(output)

    out = '  |  '.join('   '.join(i) for i in out)
    print(out, flush=True)


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
    })

    tg = "Telegram ("
    name = app.name
    if name[:len(tg)] == tg:
        icon = color(urgent, "%s%%{T-}%s%%{T%s}" % (icon, font(0, ": %s" % name[len(tg):len(name)-1]), ICON_FONT))

    return action("%s %s" % (COMMAND, app.id), font(ICON_FONT, icon))


main()
