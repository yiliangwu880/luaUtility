
g_str = g_str or {}


--fun �ָ��ַ���
--para str Դ�ַ���
--para set �ָ����ַ���
--return �������ʽ{str1, str2,..}
function g_str.split(str, sep)
	local sep, fields = sep or "\t", {}
	
	local pattern = string.format("([^%s]+)", sep)
	
	string.gsub(str, pattern, function(c) fields[#fields+1] = c end)

	return fields
end
