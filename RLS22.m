%递推最小二乘法

clear all
close all
clc
a=[1 -1.3 0.5]';b=[0.8 0.3]';d=3;  %实际系统参数与纯迟延
na=length(a)-1;nb=length(b)-1;  %%na,nb 为输出输入系数矩阵 A,B 的阶数
L=2000;%仿真长度
uk=zeros(d+nb,1);yk=zeros(na,1);  %输入输出初始化
yk_m=zeros(na,1); %模型输出
u=randn(L,1);  %输入信号，采用方差为1的白噪声序列
xi=sqrt(0.1)*randn(L,1);  %干扰信号，采用方差为0.1的白噪声序列

thetae_1=zeros(na+nb+1,1);  %参数初值
P=10^6*eye(na+nb+1);  %修正系数初值
lambda=0.996;  %遗忘因子范围[0.9 1],遗忘因子=1时，即为标准递推最小二乘

for k=1:L
    if k==801
        a=[1 -1.0 0.3]';b=[0.6 0.2]';  %系统参数突变
    end
    theta(:,k)=[a(2:na+1);b];  %系统参数真值
    
    phi=[-yk;uk(d:d+nb)];  %输出输入矩阵
    phi_e=[-yk_m;uk(d:d+nb)]; %模型输出输入矩阵
    y(k)=phi'*theta(:,k)+xi(k);  %系统实际输出
    y_m(k)=phi_e'*thetae_1; %模型输出
    
    %递推公式
    K=P*phi/(lambda+phi'*P*phi);
    thetae(:,k)=thetae_1+K*(y(k)-phi'*thetae_1);
    P=(eye(na+nb+1)-K*phi')*P/lambda;
    
    %更新数据
    thetae_1=thetae(:,k);
    for i=d+nb:-1:2
        uk(i)=uk(i-1);
    end
    uk(1)=u(k);
    
    for i=na:-1:2
        yk(i)=yk(i-1);
        yk_m(i)=yk_m(i-1);
    end
    yk(1)=y(k);
    yk_m(1)=y_m(k);
end
figure('name','参数a')
plot([1:L],thetae(1:na,:));hold on;plot([1:L],theta(1:na,:),'k:');
xlabel('k');ylabel('参数估计a');
legend('a_1','a_2');axis([0 L -2 1]);
figure('name','参数b')
plot([1:L],thetae(na+1:na+nb+1,:));hold on;plot([1:L],theta(na+1:na+nb+1,:),'k:');
xlabel('k');ylabel('参数估计b');
legend('b_0','b_1');axis([0 L 0 1]);
figure('name','输出')
plot([1:L],y,[1:L],y_m,'r');
legend('实际输出','模型输出');
axis([0 L -10 10]);
grid on;
