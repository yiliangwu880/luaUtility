--[[
随意写测试代码
]]

local g_utility = require("./utility")

t = {
    a=11,
    1,2,3,
    b=22,
    c=33
}
function f1()
    return t
end
local ff = f1()
ff.a = 33

TableInfo(t)

--
--setmetatable(t, {__mode = "v",
--
--})
--
--obj={1,2,3}
--setmetatable(obj, {
--                 __gc = function(t, k, a)
--                     print("gc t,k=", t, k , a)
--                     TableInfo(t)
--                 end,
--})
--print(obj)
--print(t)
--t["a"] = obj
--obj={}
--t["b"] = obj
--t[1] = obj
--collectgarbage()
--TableInfo(t)





