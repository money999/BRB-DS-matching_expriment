function [ result, wt, ws] = goalPro( m1, m0, mA )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明


w = log( (1-m0)./(1-m1) );
w(w<0) = 0;
ws = w;
%这一步是把最大化问题变成最小化问题，文章example 1.中有提到
w = max(max(w)) - w;


%生成01规划所要的约束条件
num = size(w,1);
m1 = [];
m2 = [];
for i = 1:num
    ta = zeros(num);
    ta(i,:) = 1;
    m1 = [m1 ta];
    m2 = [m2 eye(num)];
end
mA = [m1; m2];

% wt = reshape(1:num*num, num, num);
% wt = wt';
wt = w;

% f = [];
% ft = sum(wt);
% for i = 1:num
%     f = [f ft];
% end



%%%01规划
f = reshape(wt, num*num,1);%目标函数
intcon = 1:num*num;%每个都是整数   这个意思是那几个位置需要为整数
Aeq = mA;%等式约束保证行列和为1
beq = ones(num*2, 1);
lb = zeros(num*num,1);%下限0
ub = ones(num*num,1);%上限1
options = optimoptions('intlinprog', 'Display', 'off');
result = intlinprog(f, intcon, [], [], Aeq, beq, lb, ub, options);
result = reshape(result, num, num);


