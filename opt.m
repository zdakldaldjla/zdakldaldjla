%����������PIģ��

clear;clc; %cd('D:\�ҵ�\lib');
%***************����������ݼ��䴦��**********
t=1:0.1:10;
disp =sin(t);
u = cos(t);
n =length(u);	%����������ȡֵ����
disp_up =disp(1:n);
u_up =u(1:n);
%�Գ������߽��ж���ʽ���
%P =polyfit(u_up,disp_up,4);
%disp_fit =polyval(P,u_up);
%clear P;
%**************��϶���ӵ��趨****************
r =0.1:0.1:1;
%r =
% r=40:1.08:100;
%r1 =100:5:199.53;
%r =[r r2 r3 r1];
%clear r1 r2 r3;
n_r =length(r);
%*************����������С*****************
% y(1) =max( u_up(1)-0, min(u_up(1)+0, 0));
y=zeros(size(u));
% H =0;
% yH =0;
for i =2:91;
      y(i) =max( u_up(i)-0.2, min(u_up(i)+0.2, y(i-1)));
%      H =(y')*y +H;
%       yH =disp_up(i) *(y') +yH;
end
%����С�������еĵ�һ,����
% HH =H *2;
% YH =-2*yH;
% b =ones(n_r,1).*(-0.001);
% A =ones(n_r)*(-1);
% for i =1:1:n_r
%  for j =(i+1):1:n_r
%    A(i,j) = 0;
%  end
% end
t =ones(n_r,1);
% w =quadprog(HH,YH,A,b,[],[],v,t);
% clear i j t b A H yH n v n_r;
%**************��ͼ���۲�ģ��*******************
t =[];
% for i =2:1:length(u)
%       y(i) =max( u_up(i)-r, min(u_up(i)+r, y(i-1)));
%     t =[t;y]; 
% end
y=0;
for i =1:1:n;
      y =max( u_up(i) -r, min( u_up(i) +r, y));
end


for i =1:1:length(u)
    y =max( u(i) -r, min( u(i) +r, y));
    t =[t;y]; 
end

disp_model =(w') *(t');
figure('color','white')
plot(u,disp_model,'b');
hold on
plot(u,disp,'r');
e=disp -disp_model;
plot(u,e,'g');
hold off
xlabel('Voltage V/V');
ylabel('Displacement disp/{\mu}m');
legend('ģ�����','ʵ�����','���');
Erro_Max=max(abs(e))
Erro_Avg=sum(abs(e))/length(u)

t =(1:1:length(u))*0.01;
figure('color','white')
c =plot(t,disp_model,'r');
hold on
d =plot(t,disp,'b');
e=disp -disp_model;
plot(t,e,'g');
hold off
xlabel('Time t/s');
ylabel('Displacement disp/{\mu}m');
legend('ģ�����','ʵ�����','���');
