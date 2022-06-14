%������С���˷�

clear all
close all
clc
a=[1 -1.3 0.5]';b=[0.8 0.3]';d=3;  %ʵ��ϵͳ�����봿����
na=length(a)-1;nb=length(b)-1;  %%na,nb Ϊ�������ϵ������ A,B �Ľ���
L=2000;%���泤��
uk=zeros(d+nb,1);yk=zeros(na,1);  %���������ʼ��
yk_m=zeros(na,1); %ģ�����
u=randn(L,1);  %�����źţ����÷���Ϊ1�İ���������
xi=sqrt(0.1)*randn(L,1);  %�����źţ����÷���Ϊ0.1�İ���������

thetae_1=zeros(na+nb+1,1);  %������ֵ
P=10^6*eye(na+nb+1);  %����ϵ����ֵ
lambda=0.996;  %�������ӷ�Χ[0.9 1],��������=1ʱ����Ϊ��׼������С����

for k=1:L
    if k==801
        a=[1 -1.0 0.3]';b=[0.6 0.2]';  %ϵͳ����ͻ��
    end
    theta(:,k)=[a(2:na+1);b];  %ϵͳ������ֵ
    
    phi=[-yk;uk(d:d+nb)];  %����������
    phi_e=[-yk_m;uk(d:d+nb)]; %ģ������������
    y(k)=phi'*theta(:,k)+xi(k);  %ϵͳʵ�����
    y_m(k)=phi_e'*thetae_1; %ģ�����
    
    %���ƹ�ʽ
    K=P*phi/(lambda+phi'*P*phi);
    thetae(:,k)=thetae_1+K*(y(k)-phi'*thetae_1);
    P=(eye(na+nb+1)-K*phi')*P/lambda;
    
    %��������
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
figure('name','����a')
plot([1:L],thetae(1:na,:));hold on;plot([1:L],theta(1:na,:),'k:');
xlabel('k');ylabel('��������a');
legend('a_1','a_2');axis([0 L -2 1]);
figure('name','����b')
plot([1:L],thetae(na+1:na+nb+1,:));hold on;plot([1:L],theta(na+1:na+nb+1,:),'k:');
xlabel('k');ylabel('��������b');
legend('b_0','b_1');axis([0 L 0 1]);
figure('name','���')
plot([1:L],y,[1:L],y_m,'r');
legend('ʵ�����','ģ�����');
axis([0 L -10 10]);
grid on;
