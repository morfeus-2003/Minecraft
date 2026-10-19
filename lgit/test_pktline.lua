local pktline = require("pktline")

local function check(name, got, expected)
	if got == expected then
		print("PASS")
	else
		print("FAIL - " .. name .. ";  expected: " .. tostring(expected) .. "\ngot: " .. tostring(got))
	end
end

check("encode", pktline.encode("command=ls-refs\n"), "0014command=ls-refs\n")
check("line", pktline.line("version 2"), "000eversion 2\n")
check("encode", pktline.encode(""), "0004")
check("FLUSH", pktline.FLUSH, "0000")
check("encode", #pktline.encode(string.rep("a", 65516)), 65520)
check("encode", pcall(pktline.encode, string.rep("a", 65517)), false)
