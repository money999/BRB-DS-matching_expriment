clear;

% [x,y]=meshgrid([-5:5],[-5:5]);
% X = [x(:) y(:)];
% z =mvnpdf(X,[0,0], 0.04*eye(2));
% h= mesh(x,y,reshape(z,11,11));
% set(h,'edgecolor','none','facecolor','interp'); 

% v_dir = 2*pi;
% v_nor = 0.5;
% num = 500;
% dir = rand(num,1)*v_dir;
% nor = rand(num,1)*v_nor;
% v1(:,1) = cos(dir).*nor;
% v1(:,2) = sin(dir).*nor;
% 
% dir = rand(num,1)*v_dir;
% nor = rand(num,1)*v_nor;
% v2(:,1) = cos(dir).*nor;
% v2(:,2) = sin(dir).*nor;
% 
% err = pdist2(v1,v2);
% max(max(err))

% rr = mvnrnd([0,0], 0.04*eye(2), 500);
% max(rr)
% min(rr)


% [sp, sv, sc, p1, v1, c1, p2, v2, c2] = generateSource(1000, 5, 2*pi, 0.5, 1);
% rrrr = pdist2(v1, v2);
% min(min(rrrr))


x0 = [pi; 0; 0.5; 0.3];
A = [eye(4); -eye(4)]; b = [2*pi; 2*pi; 0.5; 0.5; 0; 0; 0; 0];
options = optimset('Display','notify');
[y,fval,flag] = fmincon('testfun',x0,[],[],[],[],[0;0;0;0],[2*pi;2*pi;0.5;0.5],[],options);
%[y,fval,flag] = fmincon('testfun',x0,A,b,[],[],[],[],[],options);
y
fval
flag

% [sp, sv, sc, p1, v1, c1, p2, v2, c2] = generateSource(10, 5, 2*pi, 0.5, 0.8);
% wAttri = ones(3,1) ;%设置属性权重，和为1%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [em1,em0,emA, mH0, mH1] = erCombine(p1, v1, c1, p2, v2, c2, 0.7, 0.2, 0.7, 0.2, wAttri);
% 
% [dm1,dm0,dmA] = dsCombine(p1, v1, c1, p2, v2, c2, 0.7, 0.2, 0.7, 0.2);

% num = 5;
% m1 = [];
% m2 = [];
% for i = 1:num
%     ta = zeros(num);
%     ta(i,:) = 1;
%     m1 = [m1 ta];
%     m2 = [m2 eye(num)];
% end
% mA = [m1; m2];
% 
% 
% wt =[   0.667133912749989                   0                   0                   0                   0
%                    0   0.485126384434763                   0                   0                   0
%                    0                   0   0.988883172569982                   0                   0
%                    0                   0                   0   0.789733665169483                   0
%                    0   0.074145606916148                   0                   0   0.354905883669699];
% 
% wt = max(max(wt)) - wt;
%                
%                
%wt = reshape(1:num*num, num, num);
%wt = wt';
% f = [];
% ft = sum(wt);这里w与R是点乘艹
% for i = 1:num
%     f = [f ft];
% end

% 
% %%%01规划
% f = reshape(wt, num*num,1);
% intcon = 1:num*num;%每个都是整数
% Aeq = mA;
% beq = ones(num*2, 1);
% lb = zeros(num*num,1);%下限0
% ub = ones(num*num,1);%上限1
% result = intlinprog(f, intcon, [], [], Aeq, beq, lb, ub);
% result = reshape(result, num, num);

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


