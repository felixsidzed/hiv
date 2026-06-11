--!strict
--!optimize 2

function foreachv<K, V>(t: { [K]: V }, f: (V) -> ())
	for _, v in t do f(v) end
end

function foreachk<K, V>(t: { [K]: V }, f: (K) -> ())
	for k in t do f(k) end
end

function zip(...): { any }
	local va = {...}
	local minl = math.huge
	for _, arr in va do minl = math.min(minl, #arr) end
	
	local result = {}	
	for index = 1, minl do
		local pair = {}
		for i, arr in va do pair[i] = arr[index] end
		table.insert(result, pair)
	end
	return result
end

function any<T>(t: {T}, f: (T) -> boolean): boolean
	for _, v in t do if f(v) then return true end end
	return false
end

function all<T>(t: {T}, f: (T) -> boolean): boolean
	for _, v in t do if not f(v) then return false end end
	return true
end

function try_insert<V>(t: {V}, val: V): ()
	if not table.find(t, val) then table.insert(t, val) end
end

function keys<K>(t: {[K]: any}): {K}
	local result = {}
	for k in t do table.insert(result, k) end
	return result
end

function values<V>(t: {[any]: V}): {V}
	local result = {}
	for _, v in t do table.insert(result, v) end
	return result
end

function transform<T, U>(t: {T}, f: (T) -> U): {U}
	local result = table.create(#t)
	for i, v in t do result[i] = f(v) end
	return result
end

function filter<T>(t: {T}, f: (T) -> boolean): {T}
	local result = {}
	for _, v in t do if f(v) then table.insert(result, v) end end
	return result
end

function find_first<T>(t: {T}, f: (T) -> boolean): T?
	for _, v in t do if f(v) then return v end end
	return nil
end

function find_last<T>(t: {T}, f: (T) -> boolean): T?
	local result: T? = nil
	for _, v in t do if f(v) then result = v end end
	return result
end

function count<T>(t: {T}, f: (T) -> boolean): number
	local result = 0
	for _, v in t do if f(v) then result += 1 end end
	return result
end

function chunk<T>(t: {T}, n: number): {{T}}
	local result, i = {}, 1
	while i <= #t do
		local c = {}
		for j = i, math.min(i + n - 1, #t) do table.insert(c, t[j]) end
		table.insert(result, c)
		i += n
	end
	return result
end

function reverse<T>(t: {T}): {T}
	local result, len = {}, #t
	for i = 1, len do result[i] = t[len - i + 1] end
	return result
end

function shuffle<T>(t: {T}): {T}
	for i = #t, 2, -1 do
		local j = math.random(i)
		t[i], t[j] = t[j], t[i]
	end
	return t
end

function merge(...): {[any]: any}
	local result: {[any]: any} = {}
	for _, t in {...} do
		for k, v in t do result[k] = v end
	end
	return result
end

function pick<K, V>(t: {[K]: V}, ks: {K}): {[K]: V}
	local r: {[K]: V} = {}
	for _, k in ks do if t[k] ~= nil then r[k] = t[k] end end
	return r
end

function is_empty(t: {[any]: any}): boolean
	return next(t) == nil
end

return {
	foreachv = foreachv, foreachk = foreachk,
	zip = zip, any = any, all = all, try_insert = try_insert,
	keys = keys, values = values, transform = transform, filter = filter,
	find_first = find_first, find_last = find_last, count = count,
	chunk = chunk, reverse = reverse, shuffle = shuffle,
	merge = merge, pick = pick, is_empty = is_empty,
}
