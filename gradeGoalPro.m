function [ result ] = gradeGoalPro( alpha1, alpha0, alphaA, uti)
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%   Ч��ֵ��˳���� 1 ��0  

f = uti(1) * alpha1 + uti(2) * alpha0 + (sum(uti) * alphaA)/2;

w = f;
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


%%%01�滮
f = reshape(w, num*num,1);%Ŀ�꺯��
intcon = 1:num*num;%ÿ����������   �����˼���Ǽ���λ����ҪΪ����
Aeq = mA;%��ʽԼ����֤���к�Ϊ1
beq = ones(num*2, 1);
lb = zeros(num*num,1);%����0
ub = ones(num*num,1);%����1
options = optimoptions('intlinprog', 'Display', 'off');
result = intlinprog(-f, intcon, [], [], Aeq, beq, lb, ub, options);%�Ӹ����������ֵ
result = reshape(result, num, num);

end

