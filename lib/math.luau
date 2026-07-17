--!strict
--!optimize 2

function isint(n: number): boolean
	return n % 1 == 0
end

function sum(...)
	-- since select is a known builtin this is faster than localizing select
	local result = 0
	for i = 1, select("#", ...) do
		result += select(i, ...)
	end
	return result
end

return {
	isint = isint, sum = sum
}
