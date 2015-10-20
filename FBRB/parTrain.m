function [ rule, x,fval,flag] = parTrain( pNum )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明



[sp, sv, sc, p1, v1, c1, p2, v2, c2] = generateSource(pNum, 5, 2*pi, 0.5, 1);
rule = initRule(7.5, 2.5, 1, 3, 3, 3);

rNum = size(rule,2);

x0 = ones(rNum * 3 + 3, 1) * 0.5;
x0Num = size(x0, 1);

x0(x0Num) = 0.3;
x0(x0Num - 1) = 0.3;
x0(x0Num - 2) = 0.3;

A = zeros(rNum, rNum * 3 + 3);
for i = 1:rNum
      k = i * 3;
      A(i, k - 2) = 1;
      A(i, k - 1) = 1;
end
b = ones(rNum,1); %A*x0 = b
lb = zeros(rNum * 3 + 3, 1);
ub = ones(rNum * 3 + 3, 1);


options = optimset('Display' , 'Iter' , 'MaxFunEvals' , 20000*length(x0) , 'MaxIter', 10000 , 'TolFun' , 1e-6 , 'TolX' , 1e-6 , 'TolCon', 1e-6);
[x,fval,flag] = fmincon(@(x) fminFun(p1,v1,c1, p2,v2,c2,rule, x ) ,x0, [], [], A, b, lb, ub,[],options);

xN = 0;
rNum = size(rule,2);
xNum = size(x, 1);
for i = 1:rNum
    rule(i).B0 = x(xN + 1);
    rule(i).B1 = x(xN + 2);
    rule(i).wR = x(xN + 3);
    xN = xN + 3;
    
    rule(i).wPA = [x(xNum - 2) x(xNum - 1) x(xNum)];
end

end

