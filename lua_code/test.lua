local g_utility = require("./utility")

t =
{
    11,2,3,
    d={
        3,a=3,
        b={3,a=3,}
    },
    end3={
        1,
        e1=3,
    },
}

t.end3.e1 = t.d

local function IsLeftBefore(a,b)
    return a<b
end
table.sort(t, ss)
TableInfo(t)
