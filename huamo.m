%��ģ���Ʒ���

% clear all;clc;
dt = 0.01;                  % ʱ����
N =20001;                   % ����
t=0:dt:(N-1)*dt;            	% ʱ��
% t=t2;
x1d=y3;

% x1d =3.5*sin(pi/4*t);  %����Ŀ��켣
% x1d = c2;
y=x1d;
% dx1d =pi/5*40*cos(pi/5*t);
% ddx1d=-(pi/5)^2*40*sin(pi/5*t);
% dx1d = diff(y)./diff(t);             % Ŀ��켣һ�׵���
for i=2:N-1

  dx1d(i-1)=(y(i+1)-y(i-1))/(2*dt);      %���׵���

end
for i=2:N-1

  ddx1d(i-1)=(y(i+1)+y(i-1)-2*y(i))/dt^2;      %���׵���

end

c=8;
site=10;
m=10;

b=1;
p=3;
q=5;

x1 = zeros(size(x1d));      % ״̬ x1
x2 = zeros(size(x1d));      % ״̬ x2
x10=1;
x20=1;
n=[];
k = 1;
for tt=0:dt:(N-3)*dt
%     dx1 = x20; 
%     e = x10 - x1d(k);                   % ��� e1
%     de=dx1-dx1d(k);
%     s=c*e+de;
%     ds=-site*sign(s)-m*s;
% %   e2 = x2(k) - x2d(k);                    % ��� e2
%     u = 1/B*(-A*x20+ddx1d(k)-c*de+ds);             %���ƹ���                            
%                                % dx1/dt ״̬����1
%     dx2 =-A*x20+B*u;                     %  ״̬����2       
%     
%     n=[n;x10];
%     x10 = x10 + dx1 * dt;            % ���� x1��ע���Ǽ��� dx1 * dt ������ dx1
%     x20 = x20 + dx2 * dt;            % ���� x2��ע���Ǽ��� dx2 * dt ������ dx2
%     
%     k = k + 1;                              % ��������

    dx1 = x2(k);                            % dx1/dt ״̬����1

    e1 = x1(k) - x1d(k);                   % ��� e1
%     x2d(k)=dx1d(k)-e1;                     %����״̬x2d
    de1 = x2(k) - dx1d(k);                    % ��� e2
    %% ������
%       s=c*e1+de1;
      s=b*(e1^(q/p))+de1;
    if s>0
        n=1;
    else if s<0
            n=-1;
        else
            n=0;
        end
    end
    
    ds=-site*sign(s)-m*s;
%     ds=-site*n-m*s;

    
    %% ������
%     dx2d =ddx1d(k)-x2(k)+dx1d(k);          % x2d ��һ�׵���
%     u = (-e1-e2+A*x2(k)+dx2d)/B;             %���ƹ���     
%     u = 1.7213*x2(k)-0.7189*x1(k)+ddx1d(k)-c*de1+ds;             %���ƹ���
     u = 1.7213*x2(k)-0.7189*x1(k)+ddx1d(k)-b*(q/p)*(e1^(q/p-1))*de1+ds;           %�ն˿��ƹ���

    %%
    
    n=[n;u];
    dx2 =-1.7213*x2(k)+0.7189*x1(k)+u;   %  ״̬����2  
    
    
    x1(k+1) = x1(k) + dx1 * dt;            % ���� x1��ע���Ǽ��� dx1 * dt ������ dx1
    x2(k+1) = x2(k) + dx2 * dt;            % ���� x2��ע���Ǽ��� dx2 * dt ������ dx2
    
    k = k + 1;       
end
    
% subplot(211);
plot(t, x1d, 'LineWidth', 2); hold on                  % ����Ŀ������
plot(t, real(x1), '-.', 'LineWidth', 2);hold off                          % ����ʵ���������
legend('Ŀ��ֵ', '���ֵ');xlabel('ʱ�� t(s)');ylabel('���/mm');    % ��ӱ�ע
% axis([0 10 -5 5]); % ������������ָ��������
% axis([0 21 -1.5 1.5]);

% subplot(212);plot(t, x2d, 'LineWidth', 2); hold on                  % ����Ŀ������
% plot(t, x2, '-.', 'LineWidth', 2);hold off                          % ����ʵ���������
% legend('Ŀ��ֵ', '���ֵ');xlabel('ʱ�� t(s)');ylabel('״̬ x_2');   % ��ӱ�ע
% figure 
ss=real(x1);
l=ss-x1d;
% plot(t,l);
% xlabel('ʱ�� t(s)');ylabel('x1���');
rmse = sqrt(mean((l).^2))
% mae = mean(abs((x1 - x1d)));
% meap = mean(abs((x1(2:end)-x1d(2:end))./x1d(2:end)));
mape = mean(abs((real(x1) - x1d)));
mape1=mape/abs(max(x1d)-min(x1d))
% meap1 = mean(abs((x1(3:49)-x1d(3:49))./x1d(3:49)));
% meap2 = mean(abs((x1(53:99)-x1d(53:99))./x1d(53:99)));
% meap3 = mean(abs((x1(103:149)-x1d(103:149))./x1d(103:149)));
% meap4 = mean(abs((x1(153:end)-x1d(153:end))./x1d(153:end)));
% meap=mean(meap1+meap2+meap3+meap4)
% figure 
% plot(t,x2- x2d);
% xlabel('ʱ�� t(s)');ylabel('x2���');