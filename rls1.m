%递推最小二乘法

%Inputs:
%=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=
%Y = nX1 vector of your model output
%U = nX1 vector of your model input
%Ts = sample time
%
%=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=
%Outputs:
%=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=
%sysd = discrete-time transfer function identified
%sys = continuous-time transfer function identified
%err = error
%
% if nargin<3 || nargin>3
%     error('Must be three inputs!');
% end
% if length(Y)~=length(U)
%     error('length of inputs must be equal.');
% end

% 
% t=1:0.1:50;

uk=m1;
yk=m22;
% 
% 
 N=length(uk);
% uk=rand(1, N) ;
% % uk=1:N ;
% % for i=1:N
% %     uk (i)=uk (i)*(-1)^(i-1) ;
% % end
% yk=zeros (1,N);
% for k=3:N
%     yk(k)=1.5*yk(k-1)-0.7*yk(k-2)+uk(k-1)+0.5*uk(k-2) ;
% end
U=uk;
Y=yk;
plot(Y)
n=length(U);
% Y=reshape(Y,n,1);
% U=reshape(U,n,1);
theta=[0.1;0.1;0.1;0.1];
P=2^25*eye(4);
R0=1;
for m=3:n
    X=[Y(m-1) Y(m-2) U(m-1) U(m-2)]';
%     X=[Y(m-1) U(m)]';
    alfa=1/(R0+X'*P*X);
    L=alfa*P*X;
   theta(:,m-1)=theta(:,m-2)+L*(Y(m)-X'*theta(:,m-2));
    P=P/R0-alfa*P*X*X'*P;
    err=Y(m)-X'*theta(:,m-2);
%     if abs(err)<=1e-10
%         break;
%     end
end

% x1=0;x0=0;u1=0;u0=0;
% ff=@(theta,x1,x0,u1,u0) (theta')*[x1;x0;u1;u0];
% f=@(x1,x0,u1,u0) a1*x1+a2*x0+b1*u1+b2*u0;   %递推函数(这是我们需要拟合的线性多元方程)
xx=zeros(1,N);
zz_ori=zeros(1,N);
xx=(theta(3-2))'*[xx(3-1);xx(3-2);uk(3-1);uk(3-2)];
%利用拟合估计的参数再进行递推求值,得到我们的拟合系统
for i=3:N
   xx(i)=theta(:,i-2)'*[xx(i-1);xx(i-2);uk(i-1);uk(i-2)];
   zz_ori(i-2)=xx(i);
end
% o=1:N;
% yttt=[1.7 -0.7 -0.01 0.01]*yi;
figure
hold on;plot(yk)
plot(xx','--');
plot(xx'-yk);
% plot(xx)
legend('实际输出','模型输出','误差');
% rmse = sqrt(mean((yttt-yk).^2))
rmse1 = sqrt(mean((xx(30:163)'-yk(30:163)).^2))
ooo=xx'-yk;
axis([0 165 -60 50]);


m=length(theta(1,:));
% result=[-theta(1:2,m);theta(3:4,m)];
t=1:m;
figure;
% plot(t,theta(1,:),t,theta(2,:),t,theta(3,:),t,theta(4,:),t,theta(5,:));
plot(t,theta(1,:),t,theta(2,:),t,theta(3,:),t,theta(4,:));
legend('a1','a2','b0','b1');
% num=[result(3),result(4)];
% den=[1,result(1),result(2)];
% sysd=tf(num,den);
% [n,d]=d2cm(num,den,2,'tustin');
% sys=tf(n,d);