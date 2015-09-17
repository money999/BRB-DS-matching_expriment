function [ position, velocity, class, posG1, velG1, claG1, posG2, velG2, claG2] = generateSource( nums, square, v_dir, v_nor, spurious)
%UNTITLED2 此处显示有关此函数的摘要
%   num         生成多少个点
%   square      点在平面内的范围
%   v_dir       速度的方向取值范围
%   v_nor       速度的大小取值范围
%   c_num       类别个数
%   此处显示详细说明

num = spurious * nums;%8020处理

%生成位置，保证没有重复的点
position(num, 2) = 0;
position(1,:) = rand(1,2)*square;
for i = 2:num
    while(1)
        tmpp = rand(1,2)*square;
        discov = false;
        for j = 1:i-1
            if position(j,:) == tmpp
                discov = true; break;
            end
        end
        if discov == false
            position(i,:) = tmpp;
            break;
        end
    end
end

%随机速度与方向
dir = rand(num,1)*v_dir;
nor = rand(num,1)*v_nor;
velocity(:,1) = cos(dir).*nor;
velocity(:,2) = sin(dir).*nor;

%随机类别，先随机生成+1or-1作为mean，2是方差
class = normrnd(randi(2,num,1)*2-3, 2);

dim = size(position,1);

%加燥生成第一组
posG1 = position + mvnrnd([0,0], 0.04*eye(2), dim);
velG1 = velocity + mvnrnd([0,0], 0.04*eye(2), dim);
claG1 = class + normrnd(0,0.2);

%生成第二组
posG2 = position + mvnrnd([0,0], 0.04*eye(2), dim);
velG2 = velocity + mvnrnd([0,0], 0.04*eye(2), dim);
claG2 = class + normrnd(0,0.2);


if spurious ~= 1
    num = (1 - spurious) * nums;
    num = int32(num);
    
    posG1 = [posG1; rand(num,2)*square];
    posG2 = [posG2; rand(num,2)*square];
    
    dir = rand(num,1)*v_dir;
    nor = rand(num,1)*v_nor;
    tpvel(:,1) = cos(dir).*nor;
    tpvel(:,2) = sin(dir).*nor;
    velG1 = [velG1; tpvel];
    
    dir = rand(num,1)*v_dir;
    nor = rand(num,1)*v_nor;
    tpvel(:,1) = cos(dir).*nor;
    tpvel(:,2) = sin(dir).*nor;
    velG2 = [velG2; tpvel];
    
    claG1 = [claG1; normrnd(randi(2,num,1)*2-3, 2)];
    claG2 = [claG2; normrnd(randi(2,num,1)*2-3, 2)];
    
end
end




