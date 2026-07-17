--!strict
--!optimize 2

function trim(s: string): string return s:match("^%s*(.-)%s*$") or "" end
function ltrim(s: string): string return s:match("^%s*(.*)$") or "" end
function rtrim(s: string): string return s:match("^(.-)%s*$") or "" end

function startswith(s: string, prefix: string): boolean
	return s:find(prefix, 1, true) == 1
end

function endswith(s: string, suffix: string): boolean
	return suffix == "" or s:sub(-#suffix) == suffix
end

function lpad(s: string, n: number, char: string?): string
	local len = #s
	local c = char or " "
	return len >= n and s or c:rep(n - len) .. s
end

function rpad(s: string, n: number, char: string?): string
	local len = #s
	return len >= n and s or s .. (char or " "):rep(n - len)
end

return {
	trim = trim, ltrim = ltrim, rtrim = rtrim,
	startswith = startswith, endswith = endswith,
	lpad = lpad, rpad = rpad
}
