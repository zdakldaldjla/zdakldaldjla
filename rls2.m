%递推最小二乘法

% uk=rand(1, N) ;
% for i=1:N
%     uk (i)=uk (i)*(-1)^(i-1) ;
% end
% yk=zeros (1,N);
% for k=3:N
%     yk(k)=1.5*yk(k-1)-0.7*yk(k-2)+uk(k-1)+0.5*uk(k-2) ;
% end
% % theta=(inv(psi'*psi)*psi'*y);
uk=y2;
yk=c2;
theta=[0.1;0.1;0.1;0.1;0.1;0.1;0.1;0.1;0.1;0.1];
pn=10^6*eye(10) ;
 N=length(uk);
for t=8:N/2
    ps=([min(yk(t-1),yk(t-2));min(yk(t-2),yk(t-3));min(yk(t-3),yk(t-4));min(yk(t-4),yk(t-5));min(yk(t-5),yk(t-6));min(uk(t-1),uk(t-2));min(uk(t-2),uk(t-3));min(uk(t-3),uk(t-4));min(uk(t-4),uk(t-5));min(uk(t-5),uk(t-6))]) ;
    pn=pn-pn*ps*ps'*pn*(inv(1+ps'*pn*ps));
    theta=theta+pn*ps*(yk(t)-ps'*theta);
    thet=theta';
    a1=thet(1);
    a2=thet(2);
    a3=thet(3);
    a4=thet(4);
    a5=thet(5);
    b1=thet(6);
    b2=thet(7);
     b3=thet(8);
    b4=thet(9);
     b5=thet(10);
    
    a1t(t)=a1;
    a2t(t)=a2;
     a3t(t)=a3;
    a4t(t)=a4;
     a5t(t)=a5;
    
    b1t(t)=b1; 
    b2t(t)=b2;
    b3t(t)=b3; 
    b4t(t)=b4;
    b5t(t)=b5; 
end
for t=(N)/2:N
    ps=([max(yk(t-1),yk(t-2));max(yk(t-2),yk(t-3));max(yk(t-3),yk(t-4));max(yk(t-4),yk(t-5));max(yk(t-5),yk(t-6));max(uk(t-1),uk(t-2));max(uk(t-2),uk(t-3));max(uk(t-3),uk(t-4));max(uk(t-4),uk(t-5));max(uk(t-5),uk(t-6))]) ;
    pn=pn-pn*ps*ps'*pn*(inv(1+ps'*pn*ps));
    theta=theta+pn*ps*(yk(t)-ps'*theta);
    thet=theta';
    a1=thet(1);
    a2=thet(2);
    a3=thet(3);
    a4=thet(4);
    a5=thet(5);
    b1=thet(6);
    b2=thet(7);
     b3=thet(8);
    b4=thet(9);
     b5=thet(10);
    
    a1t(t)=a1;
    a2t(t)=a2;
     a3t(t)=a3;
    a4t(t)=a4;
     a5t(t)=a5;
    
    b1t(t)=b1; 
    b2t(t)=b2;
    b3t(t)=b3; 
    b4t(t)=b4;
    b5t(t)=b5; 
end

% x1=0;x0=0;u1=0;u0=0;
% ff=@(theta,x1,x0,u1,u0) (theta')*[x1;x0;u1;u0];
% f=@(x1,x0,u1,u0) a1*x1+a2*x0+b1*u1+b2*u0;   %递推函数(这是我们需要拟合的线性多元方程)
% xx=zeros(1,N);
% zz_ori=zeros(1,N);
% % xx=(theta(3-2))'*[xx(3-1);xx(3-2);uk(3-1);uk(3-2)]
% %利用拟合估计的参数再进行递推求值,得到我们的拟合系统
% for i=3:N
%    xx(i)=theta(:,i-2)'*[xx(i-1);xx(i-2);xx(i-3);xx(i-4);xx(i-5);uk(i-1);uk(i-2);uk(i-3);uk(i-4);uk(i-5)];
%    zz_ori(i-2)=xx(i);
% end
% % o=1:N;
% figure
% hold on;plot(yk)
% plot(xx,'--');
% legend('输出','模型输出');

t=1:N;figure;
plot (t,a1t(t),t,a2t(t),t,a3t(t),t,a4t(t),t,a5t(t),t,b1t(t),t,b2t(t),t,b3t(t),t,b4t(t),t,b5t(t));
xlabel('迭代次数');ylabel('数值');
legend('a1t','a2t','a3t','a4t','a5t','b1t','b2t','b3t','b4t','b5t');



