PREFIX ?= /usr/local
LUA ?= luajit
ABIVER ?= 5.1
PREFIX_LMOD ?= $(PREFIX)/share/lua/$(ABIVER)
INSTALL ?= install

all: check
check:
	@$(LUA) zonefile.test.lua
install: zonefile.lua
	@$(INSTALL) $< $(PREFIX_LMOD)/
uninstall:
	@rm -f $(PREFIX_LMOD)/zonefile.lua

.PHONY: all check install uninstall
