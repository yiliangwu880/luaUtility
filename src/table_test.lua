
local table_util =require("./table_util")

local ms = {}
table_util.MultSetInsert(ms, 11)
assert(ms[11] == 1)
table_util.MultSetInsert(ms, 11)
assert(ms[11] == 2)
table_util.MultSetRemove(ms, 11)
assert(ms[11] == 1)
table_util.MultSetRemove(ms, 11)
assert(ms[11] == nil)

local concat1 = {1}
local concat2 = {3,4}
table_util.ConcatVaule(concat1, concat2)
assert(concat1[1]==1)
assert(concat1[2]==3)
assert(concat1[3]==4)


local lp=table_util.NewDeque()
lp:PushFront(1)
lp:PushFront(2)
lp:PushBack(-1)
lp:PushBack(-2)

local x=lp:PopFront()
assert(x==2)
x=lp:PopBack()
assert(x==-2)
x=lp:PopFront()
assert(x==1)
x=lp:PopBack()
assert(x==-1)

x=lp:PopBack()
assert(x==nil)
assert(lp:PopBack()==nil)

lp:PushFront(1)
lp:PushBack(-1)
assert(lp:PopBack()==-1)
lp:PushBack(-2)
assert(lp:PopBack()==-2)
lp:PushBack(-1)
assert(lp:PopBack()==-1)
lp:PushBack(-2)
assert(lp:PopBack()==-2)
assert(lp:PopBack()==1)
assert(lp:PopBack()==nil)

lp:PushFront(1)
lp:PushBack(-1)
assert(lp:PopBack()==-1)
lp:PushBack(-2)
lp:PushBack(-3)
local t={a=3}
lp:PushBack(t)
assert(lp:Find(-2)==-2)
assert(lp:Find(t).a==3)