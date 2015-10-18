clear;

load('rule.mat');


statistic = zeros(1,16);
for i = 1:16
    for j = 1:30
        [sp, sv, sc, p1, v1, c1, p2, v2, c2] = generateSource(i*5, 5, 2*pi, 0.5, 0.8);
        m1=[];
        m0=[];
        mA=[];
        pNum = size(p1,1);
        for ii = 1:pNum
            for jj = 1:pNum
                po1.p = p1(ii,:);
                po1.v = v1(ii,:);
                po1.c = c1(ii);
                po2.p = p2(jj,:);
                po2.v = v2(jj,:);
                po2.c = c2(jj);
                [Be1, Be0, BeA] = activeRule(rule, po1, po2);
                m1(ii,jj) = Be1;
                m0(ii,jj) = Be0;
                mA(ii,jj) = BeA;
            end
        end
        
        [result] = goalPro(m1, m0, mA);
        
        dim = size(result,1) * 0.8;%只取0.8的部分比较准确性
        result = result((1:dim),(1:dim));
        at = size(result,1) - sum(diag(result));
        
        statistic(1,i) = statistic(1,i) + at;
    end
    i
    statistic(1,i) = statistic(1,i)/(30*i*5*0.8);
    statistic(1,i) = 1 - statistic(1,i);
end
plot(5:5:80, statistic);