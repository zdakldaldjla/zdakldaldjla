%��ʶPIģ�ͣ�11������

% clc;clear all
%% ����M���� ����n=2������ȡ���ݳ���N=100

u=yo;
L=length(u);
y=m22;
% a1=1.5;a2=-0.7;b1=1.0;b2=0.5;
Y=[];
Fai=[];
for k=6:L
%     y(k)=a1*y(k-1)+a2*y(k-2)+b1*u(k-1)+b2*u(k-2);
    fai=[y(k-1),y(k-2),y(k-3),y(k-4),y(k-5),u(k),u(k-1),u(k-2),u(k-3),u(k-4),u(k-5)]';
    Fai=[Fai;fai'];
    Y=[Y;y(k)];
end
theta=inv(Fai'*Fai)*Fai'*Y

% ytt=theta'*yo;

xx=zeros(1,L);
zz_ori=zeros(1,L);
for i=6:L
   xx(i)=theta'*[y(i-1);y(i-2);y(i-3);y(i-4);y(i-5);u(i);u(i-1);u(i-2);u(i-3);u(i-4);u(i-5)];
   zz_ori(i-2)=xx(i);
end
plot((6:L),y(6:L)');title('ʵ�����')
hold on
plot((6:L),xx(6:L));title('��ʶ���')
hold on
plot((6:L),xx(6:L)-y(6:L))
legend('ʵ�����','ģ�����','���');

figure
subplot(2,1,1)
plot((6:L),y(6:L)');title('ʵ�����')
subplot(2,1,2)
plot((6:L),xx(6:L));title('��ʶ���')
rmse = sqrt(mean((xx(6:end)'-y(6:end)').^2))

