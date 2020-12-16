--配置文件，目的，让所有代码，移植到不同项目只需修改这里

local function log_detail()
    local info = debug.getinfo(2, "nSl")
    local name = info.source:match(".+%\\(.+)$") --linux 用 info.source:match(".+%/(.+)$")
    local line = info.currentline
    local func = info.name
    info = string.format("%s:%d: ", name, line)
    return info
end

function ErrorLog(...)
    g_utility.ErrorLog(log_detail(), ...)
end
function DebugLog(...)
    g_utility.DebugLog(log_detail(), ...)
end

g_work_path = "./"  --main.lua 的工作目录