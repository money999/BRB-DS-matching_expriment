statistic = zeros(1,16);
for i = 1:16
    for j = 1:30
        [sp, sv, sc, p1, v1, c1, p2, v2, c2] = generateSource(i*5, 5, 2*pi, 0.5, 1);
        [m1,m0,mA] = dsCombine(p1, v1, c1, p2, v2, c2, 0.7, 0.2, 0.7, 0.2);
        [result, wt, ws] = goalPro(m1, m0, mA);
        at = size(result,1) - sum(diag(result));
        statistic(1,i) = statistic(1,i) + at;
    end
    statistic(1,i) = statistic(1,i)/(30*i*5);
    statistic(1,i) = 1 - statistic(1,i);
end
plot(5:5:80, statistic);
