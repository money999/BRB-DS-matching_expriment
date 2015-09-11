num = 5;
m1 = [];
m2 = [];
for i = 1:num
    ta = zeros(num);
    ta(i,:) = 1;
    m1 = [m1 ta];
    m2 = [m2 eye(num)];
end
mA = [m1; m2];


wt =[   0.667133912749989                   0                   0                   0                   0
                   0   0.485126384434763                   0                   0                   0
                   0                   0   0.988883172569982                   0                   0
                   0                   0                   0   0.789733665169483                   0
                   0   0.074145606916148                   0                   0   0.354905883669699];

wt = max(max(wt)) - wt;
               
               
%wt = reshape(1:num*num, num, num);
%wt = wt';
% f = [];
% ft = sum(wt);这里w与R是点乘艹
% for i = 1:num
%     f = [f ft];
% end



%%%01规划
f = reshape(wt, num*num,1);
intcon = 1:num*num;%每个都是整数
Aeq = mA;
beq = ones(num*2, 1);
lb = zeros(num*num,1);%下限0
ub = ones(num*num,1);%上限1
result = intlinprog(f, intcon, [], [], Aeq, beq, lb, ub);
result = reshape(result, num, num);


% mAt = [];
% for i = 1:num
%     m1 = [];
%     for j = 1:num
%         m2 = zeros(num);
%         m2(j,:) = wt(i,:);
%         m1 = [m1 m2];
%     end
%     mAt = [mAt; m1];
% end


