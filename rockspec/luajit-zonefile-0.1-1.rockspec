package = "luajit-zonefile"
version = "0.1-1"
source = {
   url = "git://github.com/vavrusa/luajit-dns-zonefile"
}
description = {
   summary = "FFI bindings for Knot DNS zone file parser.",
   detailed = [[
   ]],
   homepage = "https://github.com/vavrusa/luajit-dns-zonefile",
   license = "BSD"
}
dependencies = {
   "lua >= 5.1", -- "luajit >= 2.0.0"
}
external_dependencies = {
    LIBZSCANNER = {
       library = "zscanner"
    }
 }
build = {
  type = "make"
}
