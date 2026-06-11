--!strict
--!optimize 2

function bind<R>(f: (...any) -> R, ...): (...any) -> R
	local bound = {...}
	return function(...)
		local va = {...}
		local argv = table.clone(bound)
		for _, v in va do table.insert(argv, v) end
		return f(unpack(argv))
	end
end

function range(start: number, stop: number?, step: number?): { number }
	local result = {}
	local stepp = step or 1 -- retard lsp
	if stop then
		for i=start,stop-stepp,stepp do
			table.insert(result, i)
		end
	else
		for i=0,start-stepp,stepp do
			table.insert(result, i)
		end
	end
	return result
end

return {
	bind = bind, range = range
}
