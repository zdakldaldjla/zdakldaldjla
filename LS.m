%��С���˷�

%�������:y(k)-1.5y(k-1)+0.7y(k-2)=v(k)+u(k)-0.8u(k-1)
%��ʶģ��:y(k)+a1 y(k-1)+a2 y(k-2)=v(k)+b1 u(k)+b2 u(k-1)
%���ݳ���ȡn=20000,��Ȩ����ΪI��v(k)�Ƿ�����̬�ֲ��İ�����N��0,1��,u(k)=sin(k)
%�����Ʋ���K=[a1 a2 a3 a4]'��׼����J(K)=(Yn-HnK)'(Yn-HnK);
%����ʶģ��дΪ��y(k)=v(k)+a1 y(k-1)+a2 y(k-2)+b1 u(k)+b2 u(k-1)
%                    =v(k)+KHn
%Hn=|y(2) y(1)|
%   |y(3) y(2)|
%%   |.........|
% clear
% close all
u=yo;
y=m2;
data_length=length(u);
%% ����������������
% v=randn(1,data_length);
% v=v./max(v);
% u=zeros(1,data_length);
% for k=1:data_length
%     u(k)=sin(k);
% end
% %% ��ù۲�ֵ
% y=zeros(1,data_length);
% for k=3:data_length
%     y(k)=1.5*y(k-1)-0.7*y(k-2)+v(k)+u(k)-0.8*u(k-1);
% end
%% ����Hn��Y����
Hn=zeros(data_length-2,2);
count=1;
for k=1:(data_length-1)/2
    Hn(k,2)=y(count);
    count=count+1;
    Hn(k,1)=y(count);
    Hn(k,4)=u(count);
    Hn(k,3)=u(count+1);
end
%% ������
Y=y(3:data_length)';
c1=Hn'*Hn;
c2=inv(c1);
c3=Hn'*Y;   
K=c2*c3

%% ����ʶ�õ��Ĳ������룬�ù������
y_e=zeros(1,data_length);
for k=3:data_length
    y_e(k)=K(1)*y_e(k-1)+K(2)*y_e(k-2)+K(3)*u(k)+K(4)*u(k-1);
end
ytt=K'*yo;
%% ����ʵ������ͱ�ʶ��������жԱ�
plot((1:data_length),y');title('ʵ�����')
hold on
plot((1:data_length),ytt');title('��ʶ���')
plot((1:data_length),ytt'-y')
figure
subplot(2,1,1)
plot((1:data_length),y');title('ʵ�����')
subplot(2,1,2)
plot((1:data_length),ytt');title('��ʶ���')
rmse = sqrt(mean((ytt'-y').^2))
