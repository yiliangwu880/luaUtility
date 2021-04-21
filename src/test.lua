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


local str = "ab"
print("ddd end", string.byte(str), string.byte(str,2,2))
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





