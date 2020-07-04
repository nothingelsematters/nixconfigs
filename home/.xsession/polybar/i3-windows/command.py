import sys
import i3ipc

appId = int(sys.argv[1])

i3 = i3ipc.Connection()

selected_app = next(app for app in i3.get_tree().leaves() if app.id == appId)

assert(selected_app)

selected_app.command('focus')
