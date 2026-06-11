--!strict
--!optimize 2

local filter1 = math
local filter2 = string
local filter3 = table
require("./")({
	"*"
})

for k, v in getfenv() do
	if k == "std" then
		print("std:")
		table.foreachk(v, print)
		print()
	elseif k == "math" then
		print("math:")
		for l in v do
			if not filter1[l] then
				print(l)
			end
		end
		print()
	elseif k == "string" then
		print("string:")
		for l in v do
			if not filter2[l] then
				print(l)
			end
		end
		print()
	elseif k == "table" then
		print("table:")
		for l in v do
			if not filter3[l] then
				print(l)
			end
		end
		print()
	end
end
