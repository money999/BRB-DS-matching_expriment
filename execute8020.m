%op文章实验
% statistic = zeros(1,16);
% for i = 1:16
%     for j = 1:30
%         [sp, sv, sc, p1, v1, c1, p2, v2, c2] = generateSource(i*5, 5, 2*pi, 0.5, 0.8);
%         [m1,m0,mA] = dsCombine(p1, v1, c1, p2, v2, c2, 0.7, 0.2, 0.7, 0.2);
%         [result, wt, ws] = goalPro(m1, m0, mA);
%         
%         dim = size(result,1) * 0.8;%只取0.8的部分比较准确性
%         result = result((1:dim),(1:dim));
%         at = size(result,1) - sum(diag(result));
%         
%         statistic(1,i) = statistic(1,i) + at;
%     end
%     statistic(1,i) = statistic(1,i)/(30*i*5*0.8); 
%     statistic(1,i) = 1 - statistic(1,i);
% end
% plot(5:5:80, statistic);

%陈圣群实验
statistic = zeros(1,16);
for i = 1:16
    for j = 1:30
        [sp, sv, sc, p1, v1, c1, p2, v2, c2] = generateSource(i*5, 5, 2*pi, 0.5, 0.8);
        wAttri = ones(3,1) * 1/3;%设置属性权重，和为1%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [m1,m0,mA] = erCombine(p1, v1, c1, p2, v2, c2, 0.7, 0.2, 0.7, 0.2, wAttri);
        gradeUti = [1 0]; %等级效用值%%%%%%%%%%%%%%%%%%%%%%%%  1的等级效用是1    0是-1
        [result] = gradeGoalPro(m1, m0, mA, gradeUti);
        dim = size(result,1) * 0.8;%只取0.8的部分比较准确性
        result = result((1:dim),(1:dim));
        at = size(result,1) - sum(diag(result));
        statistic(1,i) = statistic(1,i) + at;
    end
    statistic(1,i) = statistic(1,i)/(30*i*5*0.8); 
    statistic(1,i) = 1 - statistic(1,i);
end
plot(5:5:80, statistic);


