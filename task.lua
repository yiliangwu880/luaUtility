--带完成工作

--1声明全局变量
local declaredNames = {}
function declare (name, initval)
rawset(_G, name, initval)
declaredNames[name] = true
end
setmetatable(_G, {
__newindex = function (t, n, v)
if not declaredNames[n] then
error("attempt to write to undeclared var. "..n, 2)
else
rawset(t, n, v) -- do the actual set
end
end,
__index = function (_, n)
if not declaredNames[n] then
error("attempt to read undeclared var. "..n, 2)
else
return nil
end
end,
})

使用方法：
> a = 1
stdin:1: attempt to write to undeclared variable a
> declare "a"
> a = 1 -- OK

--2
