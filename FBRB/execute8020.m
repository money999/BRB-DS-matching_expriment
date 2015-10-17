clear;
pNum = 20;

rule = initRule(7.5, 2.5, 1, 5, 5, 5);
[sp, sv, sc, p1, v1, c1, p2, v2, c2] = generateSource(pNum, 5, 2*pi, 0.5, 0.8);

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
dim = size(result,1) * 0.8;%只取0.8的部分比较准确性
result = result((1:dim),(1:dim));
at = size(result,1) - sum(diag(result));
preRate = 1 - at / (pNum * 0.8);

