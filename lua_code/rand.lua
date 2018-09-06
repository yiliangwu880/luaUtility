
g_rand = g_rand or {} 
math.randomseed(os.time())


--�����������Ԫ��λ��
--para[in,out] array
function g_rand.random_shuffle(array)
	local counter = #array
	while counter > 1 do
		local index = math.random(counter) 
		array[index], array[counter] = array[counter], array[index]
		counter = counter - 1
	end
	return array
end

--����Ȩ�����������{[1]=10, [2]=90}.���1�ļ�����10%
--para tWeight Ϊ���Ȩ������, ���� {10,20,...}
--return ��������1��ʼ
function g_rand.RandomWeight(tWeight)
	local sum = 0
	for i,v in ipairs(tWeight) do
		sum = sum + v
	end
	if 0 == sum then
		return 1
	end

	local randWeight = math.random(1, sum)
	local i = 0;
	local current_sum = 0;
	for i,v in ipairs(tWeight) do
		current_sum = current_sum + v
		if randWeight <= current_sum then
			return i;
		end
	end
	ErrorLog("error logic") --����������
	return 1
end