%������С����ʾ������
%���ʱ�䣺2020/11/14
%���ߣ�lamphungry
%ԭ�����룬����Ҳο�
clc;clear;
times=2;                                    %�ظ�4������
x1=0;x0=0;u1=0;u0=0;N=50+2;                 %����״̬������4����ֵ(ȡ0)��������״̬�������ܸ���
a1=1.5;a2=-0.7;b1=1;b2=0.5;                 %��ʼ��ϵͳ����(����������Ҫ�����Ĳ���))
f=@(x1,x0,u1,u0) a1*x1+a2*x0+b1*u1+b2*u0;   %���ƺ���(����������Ҫ��ϵ����Զ�Ԫ����)
x=zeros(1,times*N);x(1:2)=[x0 x1];          %Ԥ����ռ䲢��ʼ��ǰ����ֵ

%�������룬ʹ�����0-1���У�����ΪN-1
u=(idinput(N)'+1)/2;u(1:2)=[u0 u1];
u=repmat(u,1,times);
T=1;n=1:times*N;t=n*T;

%�������������������������������˹������,\delta_v^2=0.01^2
delta_v=0.01;
z=zeros(1,times*N);z_ori=zeros(1,times*N);
z(1:2)=x(1:2)+delta_v*randn(1,2);			%��������
z_ori(1:2)=x(1:2);							%������

for i=3:times*N
   x(i)=f(x(i-1),x(i-2),u(i-1),u(i-2));
   z(i-2)=x(i)+delta_v*randn(1);
   z_ori(i-2)=x(i);
end

figure('Name','����������������');
plot(t,z,t,z_ori);
legend('�����������','�������');

n=4;%�����Ƶ���ֵΪa1,a2,b1,b2.��4��,����ΪҲΪ4������,��times*N��
in1=x(2:end-1);
in2=x(1:end-2);
in3=u(2:end-1);
in4=u(1:end-2);

P_ori=1e6*eye(4,4);     %��ִ�����ֳ��Ե�λ����
theta_ori=[0 0 0 0];   %��ʼ��������ֵ��Ϊ0
X_ori=[in1(1);in2(1);in3(1);in4(1)];
Phi_ori=[X_ori];
Err=zeros(1,times*N);
Theta=zeros(4,times*N);

for i=2:times*N-2
    %��Phi_N
    %Phi=zeros(4,i);
    X=[in1(i);in2(i);in3(i);in4(i)];
    Phi=[Phi_ori X];
    
    %��P_{N+1}
    P=P_ori-(P_ori*X*X'*P_ori)/(1+X'*P_ori*X);
    %P=(P_ori^-1+X*X')^-1;
    
    %��K_N
    K=X'*P;
    
    %��\varepsilon_N
    varepsilon=z(i)-theta_ori*X;
    Err(i)=varepsilon^2;
    
    %����ֵ
    theta=theta_ori+varepsilon*K;
    Theta(:,i)=theta;
    
    %������һ��
    Phi_ori=Phi;
    P_ori=P;
    theta_ori=theta;
    X_ori=X;
end
% theta

%��ͼ����
ff=@(theta,x1,x0,u1,u0) theta*[x1;x0;u1;u0];
% f=@(x1,x0,u1,u0) a1*x1+a2*x0+b1*u1+b2*u0;   %���ƺ���(����������Ҫ��ϵ����Զ�Ԫ����)
xx=zeros(1,times*N);xx(1:2)=[x0 x1];
zz_ori=zeros(1,times*N);
Ori_theta=[1.5 -0.7 1 0.5];
%������Ϲ��ƵĲ����ٽ��е�����ֵ,�õ����ǵ����ϵͳ
for i=3:times*N
   xx(i)=ff(theta,xx(i-1),xx(i-2),u(i-1),u(i-2));
   zz_ori(i-2)=xx(i);
end

hold on;plot(t,zz_ori);legend('�����������','�������','������');

figure('Name','����');
plot(t,u);

figure('Name','���ֵ');
plot(t,Err);

figure('Name','����');hold on;
plot(repmat([0;times*N],1,4),repmat(Ori_theta,2,1),'LineWidth',2);
plot(repmat(t',1,4),repmat(Theta',1,1));

