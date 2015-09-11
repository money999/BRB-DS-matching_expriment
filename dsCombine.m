function [ mpvc1, mpvc0, mpvcA ] = dsCombine( pos1, vel1, cla1, pos2, vel2, cla2 , p_p, p_r, v_p, v_r)
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

%����λ��BPA
mp1 = p_p*exp(-p_r*pdist2(pos1,pos2));
mp0 = p_p - mp1;
mpA = 1 - p_p;


%�����ٶ�BPA
mv0 = v_p*(1-exp(-v_r*pdist2(vel1, vel2)));
mvA = 1 - mv0;


%�������BPA
c1tm1 = normpdf(cla1, -1,2)./(normpdf(cla1, -1,2) + normpdf(cla1, 1,2));%ע������������������ʽ����bpa
c1tm2 = 1-c1tm1;
c2tm1 = normpdf(cla2, -1,2)./(normpdf(cla2, -1,2) + normpdf(cla2, 1,2));
c2tm2 = 1-c2tm1;
dim = size(c1tm2,1);
mc0(dim, dim) = 0;
for i = 1:dim
    for j = 1:dim
        mc0(i,j) = c1tm1(i)*c2tm2(j) + c1tm2(i)*c2tm1(j);%����ͻ����
    end
end
mcA = 1 - mc0;


%%%����֤�ݺϳɸ���
%�Ⱥϳ��ٶȺ����
mvc0 = mv0.*mc0 + mvA.*mc0 + mv0.*mcA;  %������û�г�ͻ����
mvcA = mvA.*mcA;

%
ak = mp1.*mvc0;
mpvc1 = (mp1.*mvcA)./(1-ak);
mpvc0 = (mp0.*mvc0 + mpA.*mvc0 + mp0.*mvcA)./(1-ak);
mpvcA = (mpA.*mvcA)./(1-ak);
end

