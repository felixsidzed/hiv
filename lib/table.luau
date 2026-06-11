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
	for _, arr in va do
		minl = math.min(minl, #arr)
	end
	
	local result = {}
	
	for index = 1, minl do
		local pair = {}
		for i, arr in va do
			pair[i] = arr[index]
		end
		table.insert(result, pair)
	end
	
	return result
end

function any<T>(t: {T}, f: (T) -> boolean): boolean
	for _, v in t do
		if f(v) then
			return true
		end
	end
	return false
end

function all<T>(t: {T}, f: (T) -> boolean): boolean
	for _, v in t do
		if f(v) then
			return false
		end
	end
	return true
end

function try_insert<V>(t: {V}, val: V): ()
	if not table.find(t, val) then
		table.insert(t, val)
	end
end

function keys<K>(t: {[K]: any}): {K}
	local result = {}
	for k in t do
		table.insert(result, k)
	end
	return result
end

function values<V>(t: {V}): {V}
	local result = {}
	for _, v in t do
		table.insert(result, v)
	end
	return result
end

return {
	foreachv = foreachv, foreachk = foreachk,
	zip = zip, any = any, all = all,
	try_insert = try_insert,
	keys = keys, values = values,
}
