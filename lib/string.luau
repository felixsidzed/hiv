--!strict
--!optimize 2

function trim(s: string): string return s:match("^%s*(.-)%s*$") :: string end
function ltrim(s: string): string return s:match("^%s*(.-)$") :: string end
function rtrim(s: string): string return s:match("^(.-)%s*$") :: string end

function startswith(s: string, prefix: string): boolean
	return s:sub(1, #prefix) == prefix
end

function endswith(s: string, suffix: string): boolean
	return suffix == "" or s:sub(-#suffix) == suffix
end

function lpad(s: string, n: number, char: string?): string
	return (char or " "):rep(math.max(0, n - #s)) .. s
end

function rpad(s: string, n: number, char: string?): string
	return s .. (char or " "):rep(math.max(0, n - #s))
end

return {
	trim = trim, ltrim = ltrim, rtrim = rtrim,
	startswith = startswith, endswith = endswith,
	lpad = lpad, rpad = rpad
}
