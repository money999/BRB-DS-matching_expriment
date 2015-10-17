function y = fminFun(p1,v1,c1, p2,v2,c2,rule , x )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明

xN = 0;
pNum = size(p1,2);
for i = 1:pNum
    rule(i).wPA = [x(xN + 1) x(xN + 2) x(xN + 3)];
    rule(i).wR = x(xN + 4);
    rule(i).B0 = x(xN + 5);
    rule(i).B1 = x(xN + 6);
    xN = xN + 6;
end


for i = 1:pNum
    for j = 1:pNum
        po1.p = p1(i,:);
        po1.v = v1(i,:);
        po1.c = c1(i);
        po2.p = p2(j,:);
        po2.v = v2(j,:);
        po2.c = c2(j);
        [Be1, Be0, BeA] = activeRule(rule, po1, po2);
        m1(i,j) = Be1;
        m0(i,j) = Be0;
        mA(i,j) = BeA;
    end
end

[result] = goalPro(m1, m0, mA);
%dim = size(result,1) * 0.8;%只取0.8的部分比较准确性
%result = result((1:dim),(1:dim));
at = size(result,1) - sum(diag(result));
preRate = at / pNum;

y = preRate;
end

