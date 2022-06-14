%最小二乘法

%仿真对象:y(k)-1.5y(k-1)+0.7y(k-2)=v(k)+u(k)-0.8u(k-1)
%辨识模型:y(k)+a1 y(k-1)+a2 y(k-2)=v(k)+b1 u(k)+b2 u(k-1)
%数据长度取n=20000,加权矩阵为I，v(k)是服从正态分布的白噪声N（0,1）,u(k)=sin(k)
%待估计参数K=[a1 a2 a3 a4]'；准则函数J(K)=(Yn-HnK)'(Yn-HnK);
%将辨识模型写为：y(k)=v(k)+a1 y(k-1)+a2 y(k-2)+b1 u(k)+b2 u(k-1)
%                    =v(k)+KHn
%Hn=|y(2) y(1)|
%   |y(3) y(2)|
%%   |.........|
% clear
% close all
u=yo;
y=m2;
data_length=length(u);
%% 产生白噪声和输入
% v=randn(1,data_length);
% v=v./max(v);
% u=zeros(1,data_length);
% for k=1:data_length
%     u(k)=sin(k);
% end
% %% 获得观测值
% y=zeros(1,data_length);
% for k=3:data_length
%     y(k)=1.5*y(k-1)-0.7*y(k-2)+v(k)+u(k)-0.8*u(k-1);
% end
%% 构造Hn和Y矩阵
Hn=zeros(data_length-2,2);
count=1;
for k=1:(data_length-1)/2
    Hn(k,2)=y(count);
    count=count+1;
    Hn(k,1)=y(count);
    Hn(k,4)=u(count);
    Hn(k,3)=u(count+1);
end
%% 求解参数
Y=y(3:data_length)';
c1=Hn'*Hn;
c2=inv(c1);
c3=Hn'*Y;   
K=c2*c3

%% 将辨识得到的参数代入，得估计输出
y_e=zeros(1,data_length);
for k=3:data_length
    y_e(k)=K(1)*y_e(k-1)+K(2)*y_e(k-2)+K(3)*u(k)+K(4)*u(k-1);
end
ytt=K'*yo;
%% 画出实际输出和辨识输出，进行对比
plot((1:data_length),y');title('实际输出')
hold on
plot((1:data_length),ytt');title('辨识输出')
plot((1:data_length),ytt'-y')
figure
subplot(2,1,1)
plot((1:data_length),y');title('实际输出')
subplot(2,1,2)
plot((1:data_length),ytt');title('辨识输出')
rmse = sqrt(mean((ytt'-y').^2))
