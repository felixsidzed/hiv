--!strict
--!optimize 2

function bind<R>(f: (...any) -> R?, ...): (...any) -> R?
	local bound = {...}
	return function(...)
		local argv = table.clone(bound)
		for _, v in {...} do table.insert(argv, v) end
		return f(unpack(argv))
	end
end

function memoize<A, R>(f: (A) -> R): (A) -> R
	local cache: { [any]: any } = {}
	return function(a)
		if cache[a] == nil then cache[a] = f(a) end
		return cache[a]
	end
end

function once<R>(f: (...any) -> R): (...any) -> R
	local called, result = false, nil :: any
	return function(...)
		if called then
			return result
		end
		called = true
		result = f(...)
		return result
	end
end

function range(start: number, stop: number?, step: number?): { number }
	local s = step or 1
	local result = {}

	local n = 0
	if stop then
		for i = start, stop - s, s do n += 1; result[n] = i end
	else
		for i = 0, start - s, s do n += 1; result[n] = i end
	end

	return result
end

function try<R>(f: () -> R, fb: R): R
	local ok, res = pcall(f)
	return if ok then res :: R else fb
end

return {
	bind = bind, range = range, memoize = memoize, once = once, try = try
}
