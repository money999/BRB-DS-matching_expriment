function [ Be1, Be0, BeA ] = activeRule( rule, p1, p2 )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
pdis = pdist2(p1.p, p2.p);
vdis = pdist2(p1.v, p2.v);
c1tm1 = normpdf(p1.c, -1,2)/(normpdf(p1.c, -1,2) + normpdf(p1.c, 1,2));%注意点除根据文章所给公式计算bpa
c1tm2 = 1-c1tm1;
c2tm1 = normpdf(p2.c, -1,2)/(normpdf(p2.c, -1,2) + normpdf(p2.c, 1,2));
c2tm2 = 1-c2tm1;
cdis = c1tm1*c2tm2 + c1tm2*c2tm1;

dim = size(rule, 2);

for i = 1:dim
    rule(i).wPAnor = rule(i).wPA ./ max(rule(i).wPA);
    rule(i).wAct = rule(i).wR * rule(i).wPAnor(1)*pdis * rule(i).wPAnor(2)*vdis * rule(i).wPAnor(3)*cdis;
end

wSumAct = sum([rule.wAct]);
for i = 1:dim
    rule(i).wAct = rule(i).wAct ./ wSumAct;
end
%%%%%%%%%%%%%%%%%%%%%%%%%激活规则合成%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:dim
    rule(i).B0 = rule(i).wAct * rule(i).B0;
    rule(i).B1 = rule(i).wAct * rule(i).B1;
    rule(i).mw = rule(i).wAct * (1 - rule(i).B0 - rule(i).B1);
    rule(1).mu = 1 - rule(i).wAct;
end
%%%%%%%%%%%%%%%%%%%%%%%%ER解析公式合成%%%%%%%%%%%%%%%%%%%%%%%%
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

%得到等级上的置信度
Be0 = c0 / (1 - cu);
Be1 = c1 / (1 - cu);
BeA = cw / (1 - cu);

end

