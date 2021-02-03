--[[
事件管理器。用来给各个系统调用解耦用

event[eventId]=event_data
event_data[instance][fun]=true
]]
local EventMgr={}


function EventMgr:Reg(eventId, instance, fun)
    EventMgr[eventId] = EventMgr[eventId] or {}
    local event_data = EventMgr[eventId]
    event_data[instance] = event_data[instance] or {}
    event_data[instance][fun] = true
end

function EventMgr:UnReg(eventId, instance, fun)
    EventMgr[eventId] = EventMgr[eventId] or {}
    local event_data = EventMgr[eventId]
    event_data[instance] = event_data[instance] or {}
    event_data[instance][fun] = nil
end

function EventMgr:Trigger(eventId, ...)
    local event_data = EventMgr[eventId]
    if not event_data then
        return
    end
    for instance, v in pairs(event_data) do
        for fun, _ in pairs(v) do
            fun(instance, ...)
        end
    end
end

return EventMgr