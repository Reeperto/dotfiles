CFLAGS = $(pkg-config --cflags --libs /Users/reeperto/.local/share/rtx/installs/luaJIT/2.1.0-beta3--3.4.0/lib/pkgconfig/luajit.pc)

lua.o: lua_interface.c
	$(info $(CFLAGS))
	gcc -Wall -c lua_interface.c $(CFLAGS)
