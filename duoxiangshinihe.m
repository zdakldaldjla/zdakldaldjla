%����ʽ��ϱ�ʶ

% clear all;
% clc;
% x = 0:0.0001:3;
y1=m1;
y =m2;
m1=y1;
m2=y;
N=length(m1);
p = polyfit(m1,m2,6);
% zz_ori=zeros(1,N);

for i=1:N
    xx(i)=p(1)*m1(i)^6+p(2)*m1(i)^5+p(3)*m1(i)^4+p(4)*m1(i)^3+p(5)*m1(i)^2+p(6)*m1(i)+p(7);
end
plot(m2);hold on;
plot(xx,'--')

% clear
% clc
% ts=0.000006;%ϵͳ���ݺ�������ʱ��
% num=[0.71 -0.73];
% den=[1 1];
% dsys = tf( num,den,ts)%������ɢϵͳ
% csys = d2c(dsys)             %���任
% [ss, sx] = tfdata( csys, 'v' )%���s�����ķ��Ӻͷ�ĸ