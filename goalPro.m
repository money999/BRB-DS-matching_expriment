function [ result, wt, ws] = goalPro( m1, m0, mA )
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��


w = log( (1-m0)./(1-m1) );
w(w<0) = 0;
ws = w;
%��һ���ǰ������������С�����⣬����example 1.�����ᵽ
w = max(max(w)) - w;


%����01�滮��Ҫ��Լ������
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



%%%01�滮
f = reshape(wt, num*num,1);%Ŀ�꺯��
intcon = 1:num*num;%ÿ����������   �����˼���Ǽ���λ����ҪΪ����
Aeq = mA;%��ʽԼ����֤���к�Ϊ1
beq = ones(num*2, 1);
lb = zeros(num*num,1);%����0
ub = ones(num*num,1);%����1
options = optimoptions('intlinprog', 'Display', 'off');
result = intlinprog(f, intcon, [], [], Aeq, beq, lb, ub, options);
result = reshape(result, num, num);


