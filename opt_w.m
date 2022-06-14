%二范数建立PI模型

% clear;clc; %cd('D:\我的\lib');
%***************载入计算数据及其处理**********
o=0:0.1:10;
% o=1:0.1:1.4;
u = m1;
disp =m2;

n =length(u);		%初载曲线中取值点数
disp_up =disp(1:n);
u_up =u(1:n);
%对初载曲线进行多项式拟合
%P =polyfit(u_up,disp_up,4);
%disp_fit =polyval(P,u_up);
%clear P;
%**************间隙算子的设定****************
r =0:0.1:40;
%r2 =10:0.54:40;
%r3 =40:1.08:100;
%r1 =100:5:199.53;
%r =[r r2 r3 r1];
%clear r1 r2 r3;
n_r =length(r);
%*************求解二范数最小*****************
y =0;
H =0;
yH =0;
for i =1:1:n;
      y =max( u_up(i) -r, min( u_up(i) +r, y));
      H =(y')*y +H;
      yH =disp_up(i) *(y') +yH;
end
%求最小二范数中的第一,二项
HH =H *2;
YH =-2*yH;
b =ones(n_r,1).*(-0.001);
A =ones(n_r)*(-1);
for i =1:1:n_r
 for j =(i+1):1:n_r
   A(i,j) = 0;
 end
end
t =ones(n_r,1);v =zeros(n_r,1);
w =quadprog(HH,YH,A,b,[],[],v,t);
% clear i j t b A H yH n v n_r;
%**************画图，观察模型*******************
t =[];
for i =1:1:length(u)
    y =max( u(i) -r, min( u(i) +r, y));
    t =[t;y]; 
end
disp_model =(w')*(t');
figure('color','white')
plot(u,disp_model,'b');
hold on
plot(u,disp,'r');
e=disp -disp_model;
plot(u,e,'g');
hold off
xlabel('Voltage V/V');
ylabel('Displacement disp/{\mu}m');
legend('模型输出','实验输出','误差');
Erro_Max = max(abs(e))
Erro_Avg = sum(abs(e))/length(u)

o =(1:1:length(u))*0.01;
figure('color','white')
c =plot(o,disp_model,'r');
hold on
d =plot(o,disp,'b');
e=disp -disp_model;
plot(o,e,'g');
hold off
xlabel('Time t/s');
ylabel('Displacement disp/{\mu}m');
legend('模型输出','实验输出','误差');
rmse = sqrt(mean((e).^2))
