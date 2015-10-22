function y = fminFun(p1,v1,c1, p2,v2,c2, pvc, x )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明


xN = 0;
rT = 1;
rNum = size(pvc, 2) ^ 3;
%rule(rNum) = 0;
rule(rNum).B0 = 0;
rule(rNum).B1 = 0;
rule(rNum).wR = 0;
rule(rNum).wPA = [0 0 0];
rule(rNum).p = 0;
rule(rNum).v = 0;
rule(rNum).c = 0;
xNum = size(x, 1);
% pvc(1,2) = x(xNum - 2);
% pvc(2,2) = x(xNum - 1);
% pvc(3,2) = x(xNum);
wPA = [x(xNum - 2) x(xNum - 1) x(xNum - 0)];
seg = size(pvc, 2);
for i = 1:seg
    for j = 1:seg
        for k = 1:seg
            rule(rT).B0 = x(xN + 1);
            rule(rT).B1 = x(xN + 2);
            rule(rT).wR = x(xN + 3);
            xN = xN + 3;
            rule(rT).wPA = wPA;
            rule(rT).p = pvc(1,i);
            rule(rT).v = pvc(2,j);
            rule(rT).c = pvc(3,k);
            rT = rT + 1;
        end
    end
end


% for i = 1:rNum
%     rule(i).B0 = x(xN + 1);
%     rule(i).B1 = x(xN + 2);
%     rule(i).wR = x(xN + 3);
%     xN = xN + 3;
%     
%     rule(i).wPA = [x(xNum - 2) x(xNum - 1) x(xNum)];%每一条规则的前提属性权重都一样
% end

pNum = size(p1, 1);
m1(pNum, pNum) = 0;
m0(pNum, pNum) = 0;
mA(pNum, pNum) = 0;
y = 0;

%正确的取一半，错误的取一半
for i = 1:pNum
    po1.p = p1(i,:);
    po1.v = v1(i,:);
    po1.c = c1(i);
    po2.p = p2(i,:);
    po2.v = v2(i,:);
    po2.c = c2(i);
    [Be1, Be0, BeA] = activeRule(rule, po1, po2);
    y = y + Be0;
end


for i = 1:pNum
    if i == pNum - i + 1
        po1.p = p1(1,:);
        po1.v = v1(1,:);
        po1.c = c1(1);
        po2.p = p2(3,:);
        po2.v = v2(3,:);
        po2.c = c2(3);
        [Be1, Be0, BeA] = activeRule(rule, po1, po2);
        y = y + Be1;
    else
        po1.p = p1(i,:);
        po1.v = v1(i,:);
        po1.c = c1(i);
        po2.p = p2(pNum - i + 1,:);
        po2.v = v2(pNum - i + 1,:);
        po2.c = c2(pNum - i + 1);
        [Be1, Be0, BeA] = activeRule(rule, po1, po2);
        y = y + Be1;
    end
end



% for i = 1:pNum
%     for j = 1:pNum
%         po1.p = p1(i,:);
%         po1.v = v1(i,:);
%         po1.c = c1(i);
%         po2.p = p2(j,:);
%         po2.v = v2(j,:);
%         po2.c = c2(j);
%         [Be1, Be0, BeA] = activeRule(rule, po1, po2);
%         m1(i,j) = Be1;
%         m0(i,j) = Be0;
%         mA(i,j) = BeA;
%     end
% end
% [result] = goalPro(m1, m0, mA);
% at = size(result,1) - sum(diag(result));
% preRate = at / pNum;
% y = preRate;

end

