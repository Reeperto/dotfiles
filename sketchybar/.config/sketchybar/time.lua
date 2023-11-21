#!/usr/bin/env luajit

os.execute(string.format("sketchybar --set %s icon='%s'", os.getenv("NAME"), os.date("%I:%M %p")))
