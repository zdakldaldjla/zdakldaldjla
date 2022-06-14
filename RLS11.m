%递推最小二乘示例代码
%完成时间：2020/11/14
%作者：lamphungry
%原创代码，供大家参考
clc;clear;
times=2;                                    %重复4个周期
x1=0;x0=0;u1=0;u0=0;N=50+2;                 %定义状态参数的4个初值(取0)，并定义状态参数的总个数
a1=1.5;a2=-0.7;b1=1;b2=0.5;                 %初始化系统参数(这是我们需要拟合求的参数))
f=@(x1,x0,u1,u0) a1*x1+a2*x0+b1*u1+b2*u0;   %递推函数(这是我们需要拟合的线性多元方程)
x=zeros(1,times*N);x(1:2)=[x0 x1];          %预分配空间并初始化前两个值

%定义输入，使用随机0-1序列，总数为N-1
u=(idinput(N)'+1)/2;u(1:2)=[u0 u1];
u=repmat(u,1,times);
T=1;n=1:times*N;t=n*T;

%定义受噪声的输出和理论输出，引入高斯白噪声,\delta_v^2=0.01^2
delta_v=0.01;
z=zeros(1,times*N);z_ori=zeros(1,times*N);
z(1:2)=x(1:2)+delta_v*randn(1,2);			%掺杂噪声
z_ori(1:2)=x(1:2);							%无噪声

for i=3:times*N
   x(i)=f(x(i-1),x(i-2),u(i-1),u(i-2));
   z(i-2)=x(i)+delta_v*randn(1);
   z_ori(i-2)=x(i);
end

figure('Name','噪声输出和理论输出');
plot(t,z,t,z_ori);
legend('受噪声的输出','理论输出');

n=4;%待估计的数值为a1,a2,b1,b2.共4个,输入为也为4个分量,共times*N组
in1=x(2:end-1);
in2=x(1:end-2);
in3=u(2:end-1);
in4=u(1:end-2);

P_ori=1e6*eye(4,4);     %充分大的数字乘以单位矩阵
theta_ori=[0 0 0 0];   %初始参数估计值设为0
X_ori=[in1(1);in2(1);in3(1);in4(1)];
Phi_ori=[X_ori];
Err=zeros(1,times*N);
Theta=zeros(4,times*N);

for i=2:times*N-2
    %求Phi_N
    %Phi=zeros(4,i);
    X=[in1(i);in2(i);in3(i);in4(i)];
    Phi=[Phi_ori X];
    
    %求P_{N+1}
    P=P_ori-(P_ori*X*X'*P_ori)/(1+X'*P_ori*X);
    %P=(P_ori^-1+X*X')^-1;
    
    %求K_N
    K=X'*P;
    
    %求\varepsilon_N
    varepsilon=z(i)-theta_ori*X;
    Err(i)=varepsilon^2;
    
    %求新值
    theta=theta_ori+varepsilon*K;
    Theta(:,i)=theta;
    
    %进行下一轮
    Phi_ori=Phi;
    P_ori=P;
    theta_ori=theta;
    X_ori=X;
end
% theta

%绘图部分
ff=@(theta,x1,x0,u1,u0) theta*[x1;x0;u1;u0];
% f=@(x1,x0,u1,u0) a1*x1+a2*x0+b1*u1+b2*u0;   %递推函数(这是我们需要拟合的线性多元方程)
xx=zeros(1,times*N);xx(1:2)=[x0 x1];
zz_ori=zeros(1,times*N);
Ori_theta=[1.5 -0.7 1 0.5];
%利用拟合估计的参数再进行递推求值,得到我们的拟合系统
for i=3:times*N
   xx(i)=ff(theta,xx(i-1),xx(i-2),u(i-1),u(i-2));
   zz_ori(i-2)=xx(i);
end

hold on;plot(t,zz_ori);legend('受噪声的输出','理论输出','仿真结果');

figure('Name','输入');
plot(t,u);

figure('Name','误差值');
plot(t,Err);

figure('Name','参数');hold on;
plot(repmat([0;times*N],1,4),repmat(Ori_theta,2,1),'LineWidth',2);
plot(repmat(t',1,4),repmat(Theta',1,1));

