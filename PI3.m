%笨办法建立pi模型

% clear;clc; %cd('D:\我的\lib');
% %***************载入计算数据及其处理**********
% t=1:0.1:10;
% disp =40*sin(t);
% u =40* cos(t);
% n =length(u);	%初载曲线中取值点数
% disp_up =disp(1:n);
% u_up =u(1:n);
% %对初载曲线进行多项式拟合
% %P =polyfit(u_up,disp_up,4);
% %disp_fit =polyval(P,u_up);
% %clear P;
% %**************间隙算子的设定****************
% r =0:4:40;
% %r =
% % r=40:1.08:100;
% %r1 =100:5:199.53;
% %r =[r r2 r3 r1];
% %clear r1 r2 r3;
% n_r =length(r);
% %*************求解二范数最小*****************
% % y(1) =max( u_up(1)-0, min(u_up(1)+0, 0));
% y1=zeros(size(u));
% y2=zeros(size(u));
% y3=zeros(size(u));
% y4=zeros(size(u));
% y5=zeros(size(u));
% y6=zeros(size(u));
% y7=zeros(size(u));
% y8=zeros(size(u));
% y9=zeros(size(u));
% y10=zeros(size(u));
% y11=zeros(size(u));
% 
% % H =0;
% % yH =0;
% for i =2:91;
%     y1(i) =max( u_up(i)-0, min(u_up(i)+0, y1(i-1)));
% end
% 
% for i =2:91;
%     y2(i) =max( u_up(i)-4, min(u_up(i)+4, y2(i-1)));
% end
% 
% for i =2:91;
%     y3(i) =max( u_up(i)-8, min(u_up(i)+8, y3(i-1)));
% end
% 
% for i =2:91;
%     y4(i) =max( u_up(i)-12, min(u_up(i)+12, y4(i-1)));
% end
% 
% for i =2:91;
%     y5(i) =max( u_up(i)-16, min(u_up(i)+16, y5(i-1)));
% end
% 
% for i =2:91;
%     y6(i) =max( u_up(i)-20, min(u_up(i)+20, y6(i-1)));
% end
% 
% for i =2:91;
%     y7(i) =max( u_up(i)-24, min(u_up(i)+24, y7(i-1)));
% end
% 
% for i =2:91;
%     y8(i) =max( u_up(i)-28, min(u_up(i)+28, y8(i-1)));
% end
% 
% for i =2:91;
%     y9(i) =max( u_up(i)-32, min(u_up(i)+32, y9(i-1)));
% end
% 
% for i =2:91;
%     y10(i) =max( u_up(i)-36, min(u_up(i)+36, y10(i-1)));
% end
% 
% for i =2:91;
%     y11(i) =max( u_up(i)-40, min(u_up(i)+40, y11(i-1)));
% end
% y=[y1;y2;y3;y4;y5;y6;y7;y8;y9;y10;y11];


% clc;clear all
%% 生成M序列 这里n=2，我们取数据长度N=100
% L=100;
% y1=1;y2=1;y3=0;
% for i=1:L
%     x1=xor(y2,y3);      %异或
%     x2=y1;
%     x3=y2;
%     y(i)=y3;
%     if y(i)>0.5
%         u(i)=1;
%     else
%         u(i)=-1;
%     end
%     y1=x1;y2=x2;y3=x3;
% end 
% a1=1.5;a2=-0.7;b1=1.0;b2=0.5;

u=m1;
L=length(u);
y=m2;
Y=[];
Fai=[];
for k=3:L
    
    fai=[y(k-1),y(k-2),u(k-1),u(k-2)]';
    Fai=[Fai;fai'];
    Y=[Y;y(k)];
end
theta=inv(Fai'*Fai)*Fai'*Y;

xx=zeros(1,L);
zz_ori=zeros(1,L);
for i=6:L
   xx(i)=theta'*[y(i-1);y(i-2);u(i-1);u(i-2)];
   zz_ori(i-2)=xx(i);
end
plot((6:L),y(6:L)');title('实际输出')
hold on
plot((6:L),xx(6:L));title('辨识输出')
hold on
plot((6:L),xx(6:L)-y(6:L))
legend('实验输出','模型输出','误差');

figure
subplot(2,1,1)
plot((6:L),y(6:L)');title('实际输出')
subplot(2,1,2)
plot((6:L),xx(6:L));title('辨识输出')
rmse = sqrt(mean((xx(6:end)'-y(6:end)').^2))

