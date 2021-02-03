
--[[
ʵ���࣬�������
���ӣ�
local D1 = g_class.InheritClass(BaseC)
function D1:Construct(...)
    ...
end
 local obj = g_class.New(D1)    
]]

g_class = g_class or {}

--ʵ�ֹ��캯�����ȵ��û���ģ��ٵ����������
local function Construct(my_class, obj, ...)
    if my_class.base then
        Construct(my_class.base, obj, ...)
    end

    if my_class.Construct then
        my_class.Construct(obj, ...)
    end 
end

--���ഴ������
--����ඨ����Construct����������...����
function g_class.New(my_class, ...)
	local obj={}
    local mt = {__index = function(t, k)
			        local value = my_class[k]
			        obj[k] = value  --��������Ч���ã�����ÿ�ζ�����metamethod
			        return value
		        end}
    setmetatable(obj, mt)
    Construct(my_class, obj, ...)
	return obj
end

--�̳л���
--return ����������
--[[���磺
 my_class = g_class.InheritClass(base_class)
 function my_class:f1()
 ...
 end
]]
function g_class.InheritClass(base_class)
    local new_class = {}
    if nil == base_class then
        return new_class
    end

    new_class.base = base_class
    local mt = {__index = function(t, k)
			        local value = base_class[k]
			        new_class[k] = value  --��������Ч���ã�����ÿ�ζ�����metamethod
			        return value
		        end}
    setmetatable(new_class, mt)
    return new_class
end


