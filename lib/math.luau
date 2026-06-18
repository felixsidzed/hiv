--!strict
--!optimize 2

function isint(n: number): boolean
	return n % 1 == 0
end

function sum(...)
	local result = 0
	for _, v in {...} do result += v end
	return result
end

return {
	isint = isint,
	sum = sum
}
