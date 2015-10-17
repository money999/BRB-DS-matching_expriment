function [ rule ] = initRule(pMax, vMax, cMax, pSeg, vSeg, cSeg)
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   pMax, vMax, cMax ,p��v��c�������ֵ
%   pSeg, vSeg, cSeg ,p��v��c���Էָ�Ƭ����
%   �˴���ʾ��ϸ˵��
pTmp = 0:(pMax/(pSeg - 1)):pMax;
vTmp = 0:(vMax/(vSeg - 1)):vMax;
cTmp = 0:(cMax/(cSeg - 1)):cMax;
rNum = 1;
for i = 1:pSeg
    for j = 1:vSeg
        for k = 1:cSeg
            rule(rNum).p = pTmp(i);
            rule(rNum).v = vTmp(j);
            rule(rNum).c = cTmp(k);
            tmp = rand();
            rule(rNum).B0 = tmp;
            rule(rNum).B1 = 1 - tmp;
            rule(rNum).wPA = ones(1,3);
            rule(rNum).wR = 1;
            rNum = rNum + 1;
        end
    end
end

end

