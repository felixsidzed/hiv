--!strict
--!optimize 2

-- TODO: compat layer for diff runtimes
local fs = (require)("@lune/fs")

local function globmatch(file: string, patterns: { string }): boolean
	for _, glob in patterns do
		if file:match(`^{glob:gsub("([%.%+%-%^%$%(%)%%])", "%%%1"):gsub("%*", ".*"):gsub("%?", ".")}$`) then
			return true
		end
	end

	return false
end

return function(submodules: { string })
	if #submodules == 0 then return end

	local function walk(dir: string)
		for _, file in fs.readDir(dir) do
			local full = `{dir}/{file}`
			if fs.isDir(full) then
				walk(full)
			else
				local fnoext = full:sub(5):gsub("%.luau$", "")
				if globmatch(fnoext, submodules) then
					local mod = (require)(`@self/lib/{fnoext}`)
					local cur = (getfenv)(2)

					if mod._G then
						for k, v in mod._G do
							cur[k] = v
						end
						mod._G = nil
					end

					local parts = {}
					for part in fnoext:gmatch("[^/\\]+") do
						table.insert(parts, part)
					end

					if #parts == 1 then
						local part1 = parts[1]
						cur[part1] = cur[part1] or {}
						if table.isfrozen(cur[part1]) then
							for k, v in cur[part1] do
								mod[k] = v
							end
							cur[part1] = mod
						else
							cur = cur[part1]
							for k, v in mod do
								cur[k] = v
							end
						end
					else
						local leaf = parts[#parts]
						table.remove(parts)
						for _, part in parts do
							local nex = cur[part]
							if not nex then
								nex = {}
								cur[part] = nex
							end
							cur = nex
						end

						cur = cur[leaf]
						for k, v in mod do
							cur[k] = v
						end
					end
				end
			end
		end
	end

	walk("lib")
end
