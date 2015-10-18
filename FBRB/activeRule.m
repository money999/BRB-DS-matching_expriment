function [ Be1, Be0, BeA ] = activeRule( rule, p1, p2 )
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
pdis = pdist2(p1.p, p2.p);
vdis = pdist2(p1.v, p2.v);
c1tm1 = normpdf(p1.c, -1,2)/(normpdf(p1.c, -1,2) + normpdf(p1.c, 1,2));%ע������������������ʽ����bpa
c1tm2 = 1-c1tm1;
c2tm1 = normpdf(p2.c, -1,2)/(normpdf(p2.c, -1,2) + normpdf(p2.c, 1,2));
c2tm2 = 1-c2tm1;
cdis = c1tm1*c2tm2 + c1tm2*c2tm1;


pArry = sort(unique([rule.p]));
vArry = sort(unique([rule.v]));
cArry = sort(unique([rule.c]));

if(isempty(find(pArry == pdis,1)))
    pArry = [pArry(find(pArry<pdis, 1, 'last')) pArry(find(pArry>pdis, 1, 'first'))];
else
    pArry = pdis;
end

if(isempty(find(vArry == vdis,1)))
    vArry = [vArry(find(vArry<vdis, 1, 'last')) vArry(find(vArry>vdis, 1, 'first'))];
else
    vArry = vdis;
end

if(isempty(find(cArry == cdis,1)))
    cArry = [cArry(find(cArry<cdis, 1, 'last')) cArry(find(cArry>cdis, 1, 'first'))];
else
    cArry = cdis;
end
%��û����Ĺ���ͳͳɾ��
dim = size(rule, 2);
i = 1;
while(1)
    if(isempty(find(pArry == rule(i).p,1)) || isempty(find(vArry == rule(i).v,1)) || isempty(find(cArry == rule(i).c,1)))
        rule(i) = [];
        dim = dim - 1;
    else
        i = i+1;
    end
    if(i > dim)
        break;
    end
end

dim = size(rule, 2);

for i = 1:dim
    rule(i).wPAnor = rule(i).wPA ./ max(rule(i).wPA);
    rule(i).wAct = rule(i).wR * rule(i).wPAnor(1)*matDeg(pdis, rule(i).p, pArry) * rule(i).wPAnor(2) * matDeg(vdis, rule(i).v, vArry) * rule(i).wPAnor(3) * matDeg(cdis, rule(i).c, cArry);
end

wSumAct = sum([rule.wAct]);
for i = 1:dim
    rule(i).wAct = rule(i).wAct ./ wSumAct;
end
%%%%%%%%%%%%%%%%%%%%%%%%%�������ϳ�%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:dim
    rule(i).B0 = rule(i).wAct * rule(i).B0;
    rule(i).B1 = rule(i).wAct * rule(i).B1;
    rule(i).mw = rule(i).wAct * (1 - rule(i).B0 - rule(i).B1);
    rule(i).mu = 1 - rule(i).wAct;%%%�����iд��1�ˣ�����
end
%%%%%%%%%%%%%%%%%%%%%%%%ER������ʽ�ϳ�%%%%%%%%%%%%%%%%%%%%%%%%
%cu -
%cw ~
cu = prod([rule.mu]);
cw = prod([rule.mu] + [rule.mw]) - cu;
c0 = prod([rule.B0] + [rule.mw] + [rule.mu]) - (cu + cw);
c1 = prod([rule.B1] + [rule.mw] + [rule.mu]) - (cu + cw);

k = cu + cw + c0 + c1;
cu = cu / k;
cw = cw / k;
c0 = c0 / k;
c1 = c1 / k;

%�õ��ȼ��ϵ����Ŷ�
Be0 = c0 / (1 - cu);
Be1 = c1 / (1 - cu);
BeA = cw / (1 - cu);

if(Be0<0 || Be1<0)
    kkkk = 1;
end

end


function det = matDeg(dis, att, arry)
if dis == att
    det = 1;
else
    det = abs(dis - arry(3 - find(arry == att))) / abs(arry(2) - arry(1));
end
end
