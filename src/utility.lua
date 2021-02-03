--[[实用功能
--]]


local m = {}


function m.ForceGlobalName()
    setmetatable(_G, {
        __index = function (tt, kk)
                    if string.find(kk, "g_") == nil then
                        ErrorLog("read wrong global name " .. kk .. tt)
                    end
                    return tt[kk] 
                    end,
        __newindex = function (tt, kk, v)
                    if string.find(kk, "g_") == nil then
                        ErrorLog("set wrong global name " .. kk .. tt)
                    end
                        tt[kk] = v -- update original table
                    end,
    })
end

--重加载文件
function m.ReloadFile(f)
    package.loaded[f] = nil
    require(f)
end


function m.PrintTable(t)
	local tPrintedTable = {}
	

	local function DoPrint(tTable, nTier)
		nTier = nTier or 0
		
		local sPrefix = string.rep("\t", nTier)
		
		nTier = nTier + 1
		

		if nTier > 10 then
			-- 这里大于10层嵌套的， 直接return掉
			-- 还有循环引用的
			return
		end
		
		if type(tTable) ~= "table" then
			print(sPrefix .. tostring(tTable) )

			return
		end
		for i,v in ipairs(tPrintedTable) do
			if v == tTable then --递归引用table
			    print(sPrefix .. "recurse table" )
				return
			end
		end

		table.insert(tPrintedTable, tTable)

		print(sPrefix .. "{")

		for k,v in pairs(tTable) do
			if type(v) == "table" then
				print(sPrefix .. k .. " =")
				--PrintTable(v, nTier)
				DoPrint(v, nTier)
			else
				print(sPrefix .. k .. " = " .. tostring(v) )
			end

		end

		print(sPrefix .. "}")
	end

	DoPrint(t)
end

function m.All2String( ... )
    local string_format = string.format
	local tPrintedTable = {}
	local sResultString = ""
    local table_str=""
	local function Do2String(unknowValue, table_str)
        local old_table_str = table_str
        table_str = table_str .. "  "
		local sResult = ""
		if type(unknowValue) == "table" then
			if tPrintedTable[unknowValue] then--递归引用table
				return "recurse table,"
			end
			tPrintedTable[unknowValue] = true

			sResult = "{"
			for k,v in pairs(unknowValue) do
				if type(v) == "table" then
					sResult = string_format("%s\n%s=%s", sResult, table_str..tostring(k), Do2String(v, table_str))
				else
					sResult = string_format("%s\n%s=%s, ", sResult, table_str..tostring(k), tostring(v))
				end
			end
			sResult = string_format("%s\n"..old_table_str.."}, ", sResult)

		else
			sResult = string_format("%s%s,", sResult, tostring(unknowValue))
		end
		
		return sResult
	end	

	for _,v in ipairs({...}) do
		if type(v) == "table" then
			sResultString = string_format("\n%s%s\t", sResultString, Do2String(v, table_str))
		else
			sResultString = string_format("%s%s\t", sResultString, tostring(v))
		end
	end
	
	return sResultString
end


function m.ErrorLog(...)
	local s = m.All2String(...)

    print(s)
end

function m.DebugLog(...)
	local s = m.All2String(...)

	print(s)
end


function m.CheckIllegalGlobalName()

    local function IsSysKeyWord(s)
	    local sys_key__word=
	    {
	    "string",
	    "xpcall",
	    "package",
	    "tostring",
	    "print",
	    "error",
	    "os",
	    "unpack",
	    "require",
	    "getfenv",
	    "setmetatable",
	    "getmetatable",
	    "next",
	    "tonumber",
	    "tostring",
	    "io",
	    "rawequal",
	    "collectgarbage",
	    "module",
	    "ErrorLog",
	    "DebugLog",
	    "rawset",
	    "table",
	    "newproxy",
	    "_G",
	    "math",
	    "debug",
	    "pcall",
	    "type",
	    "coroutine",
	    "select",
	    "ipairs",
	    "pairs",
	    "setfenv",
	    "error",
	    "loadfile",
	    "assert",
	    "rawget",
	    "loadstring",
	    "dofile",
	    "_VERSION",
	    "load",
	    "gcinfo",
        "utf8",
        "arg",
        "rawlen",
	    }
	    for _, v in ipairs(sys_key__word) do
		    if v == s then
			    return true
		    end
	    end
	    return false
    end

    --检查全局变量名非法
    for key_name, var in pairs(_G) do
	    if not IsSysKeyWord(key_name) then
		    if nil == string.find(key_name, "^g_", 1, false) then
			    ErrorLog("error global name=", key_name)
		    end
	    end
    end

end

--fun 跟踪table的读写
--para t_t 跟踪的table
--para t_k 跟踪的key, nil表示任意key
--para op  跟踪的动作. 值为 "r"表示读，"w"表示写， nil 表示读写
--para table_name table名字字符串
--return 被跟踪的table
--使用例子 t = m.Track(t)
local proxy_table_key = {}
function m.Track(t_t, t_k, op, table_name)
	local proxy = {[proxy_table_key]=t_t}
    local mt = {
        __index = function (t, k)
				    local show_log = false
                    if nil == t_k then
				        show_log = true
                    elseif t_k == k then
				        show_log = true
				    end
                    if show_log and (op ~= "w") then
                        DebugLog("track:read " .. table_name .. "["..tostring(k).."]\n" .. debug.traceback())
                    end
                    return t_t[k] 
                end,
        __newindex = function (t, k, v)
				    local show_log = false
                    if nil == t_k then
				        show_log = true
                    elseif t_k == k then
				        show_log = true
				    end
                    if show_log and (op ~= "r")  then
                        DebugLog("track:write " .. table_name .. "["..tostring(k).."]=" .. tostring(v) .."\n".. debug.traceback())
                    end
                    t_t[k] = v 
                end
    }
    setmetatable(proxy, mt)
	return proxy
end

--fun 停止跟踪table的读写
--return 停止跟踪的table
--例子 t = m.StopTrack(t)
function m.StopTrack(proxy)
    setmetatable(proxy, nil)
	return proxy[proxy_table_key]
end

return m