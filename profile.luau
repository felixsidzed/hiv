--!strict
--!optimize 2

function transform<T, U>(t: {T}, f: (T) -> U): {U}
	local result = table.create(#t)
	for i, v in t do result[i] = f(v) end
	return result
end

function transform2<T, U>(t: {T}, f: (T) -> U): {U}
	local n = #t
	local result = table.create(n)
	for i=1,n do result[i] = f(t[i]) end
	return result
end

local n = 500
local samples = {}
for i = 1, n do
	local sample = {}
	for j = 1, math.random(1, 32) do
		table.insert(sample, math.random(1, 100))
	end
	
	samples[i] = sample
end

local function mapper(x: number): number
	return x * 2
end

for i=1,n do
	transform(samples[i], mapper)
end
for i=1,n do
	transform2(samples[i], mapper)
end
