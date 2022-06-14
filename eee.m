%辨识模型对比

N=100;
times=2;   
theta=[0 0 0 0]; 
x1=0;x0=0;u1=0;u0=0;N=50+2; 
ff=@(theta,x1,x0,u1,u0) theta*[x1;x0;u1;u0];
xx=zeros(1,N);xx(1:2)=[x0 x1];
zz_ori=zeros(1,N);
Ori_theta=[1.5 -0.7 1 0.5];
%利用拟合估计的参数再进行递推求值,得到我们的拟合系统
for i=3:N
   xx(i)=ff(theta,xx(i-1),xx(i-2),u(i-1),u(i-2));
   zz_ori(i-2)=xx(i);
end

hold on;plot(t,zz_ori)