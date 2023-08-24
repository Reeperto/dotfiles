#!/usr/bin/env luajit

local remaining = io.popen("pmset -g batt | grep -Eo '\\d+%' | cut -d% -f1", "r"):read("a")

