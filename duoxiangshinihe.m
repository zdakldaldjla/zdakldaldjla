%多项式拟合辨识

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
% ts=0.000006;%系统传递函数采样时间
% num=[0.71 -0.73];
% den=[1 1];
% dsys = tf( num,den,ts)%构造离散系统
% csys = d2c(dsys)             %反变换
% [ss, sx] = tfdata( csys, 'v' )%获得s传函的分子和分母