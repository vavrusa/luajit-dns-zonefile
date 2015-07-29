luajit-dns-zonefile
===================

This project provides a [LuaJIT FFI] bindings to Knot DNS zscanner[zscanner],
a lightning-fast zone file parser. It has both high-level API to break zone file
into a table of records and a lower-level API for record parsing without C to Lua callbacks
to achieve almost native-level performance.

For example, you can parse the zone file into a table of records.

```lua
local zonefile = require 'zonefile'
local records = zonefile.parse_file('example.com.zone')
for i = 1, #records do
	local rr = records[i]
	print(rr.owner, rr.type, len(rr.rdata))
end
```

Or parse input by chunks, see [zscanner structure][zscanner-api] for reference.

```lua
local zonefile = require 'zonefile'
local parser = zonefile.parser()
local rc = parser:parse('foo. 3600 IN A 1.2.3.4')
if rc == 0
	print(parser.r_type, parser.r_data_length)
end
```

Or use callbacks for multiple chunks.

```lua
local zonefile = require 'zonefile'
local addr_records = {}
local parser = zonefile.parser(function (parser)
	if parser.r_type == 1 then
		table.insert(addr_records, parser:current_rr())
	end
end)
for line in io.lines('example.com.zone') do
	local rc = parser:parse(line .. '\n')
	if rc ~= 0 then
		error('line', parser.line_counter, parser:last_error())
	end
end
```

Requirements
------------

- [LuaJIT]. Regular Lua doesn't have the FFI module.

- [zscanner] from libknot isn't bundled, and must be [installed separately][knot-readme].

Installation
------------

```bash
make install
```

API Reference
-------------

...

[Luajit FFI]: http://luajit.org/ext_ffi.html
[zscanner]: https://github.com/CZ-NIC/knot/tree/master/src/zscanner
[zscanner-api]: https://github.com/CZ-NIC/knot/blob/master/src/zscanner/scanner.h#L86
[knot-readme]: https://github.com/CZ-NIC/knot/blob/master/README
