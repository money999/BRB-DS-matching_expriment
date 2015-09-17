function [ mpvc1, mpvc0, mpvcA ] = erCombine( pos1, vel1, cla1, pos2, vel2, cla2 , p_p, p_r, v_p, v_r, wAttri )
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   wAttri ����Ȩ��3-by-1��Ȩ��˳����pvc
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

%mp1,mp0,mpA,    mv0,mvA,     mc0,mcA;
%��ԭ����õ�BPA����Ȩ��
% m~H -> mw
% m-H -> mu
mH1p = mp1 * wAttri(1);
mH0p = mp0 * wAttri(1);
muHp = 1 - wAttri(1);
mwHp = mpA * wAttri(1)

%mH1v = mv1 * wAttri(2);mv1��0����
mH0v = mv0 * wAttri(2);
muHv = 1 - wAttri(2);
mwHv = mvA * wAttri(1);

%mH1c = mc1 * wAttri(3);
mH0c = mc0 * wAttri(3)
muHv = 1 - wAttri(3);
mwHv = mcA * wAttri(3);



end

