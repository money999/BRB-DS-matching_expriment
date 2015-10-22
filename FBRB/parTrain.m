function [ rule, x,fval,flag] = parTrain( pNum )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明


[sp, sv, sc, p1, v1, c1, p2, v2, c2] = generateSource(pNum, 5, 2*pi, 0.5, 1);

%rule = initRule(7.5, 2.5, 1, 3, 3, 3);
pvc = [0 8; 0 3; 0 1];
rNum = size(pvc,2) ^ 3;

x0 = [ones(rNum * 3, 1) * 0.5; 0.1; 0.8; 0.9];


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
[x,fval,flag] = fmincon(@(x) fminFun(p1,v1,c1, p2,v2,c2, pvc, x ) ,x0, [], [], A, b, lb, ub,[],options);


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


end

