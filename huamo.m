%滑模控制方法

% clear all;clc;
dt = 0.01;                  % 时间间隔
N =20001;                   % 点数
t=0:dt:(N-1)*dt;            	% 时间
% t=t2;
x1d=y3;

% x1d =3.5*sin(pi/4*t);  %跟踪目标轨迹
% x1d = c2;
y=x1d;
% dx1d =pi/5*40*cos(pi/5*t);
% ddx1d=-(pi/5)^2*40*sin(pi/5*t);
% dx1d = diff(y)./diff(t);             % 目标轨迹一阶导数
for i=2:N-1

  dx1d(i-1)=(y(i+1)-y(i-1))/(2*dt);      %二阶导数

end
for i=2:N-1

  ddx1d(i-1)=(y(i+1)+y(i-1)-2*y(i))/dt^2;      %二阶导数

end

c=8;
site=10;
m=10;

b=1;
p=3;
q=5;

x1 = zeros(size(x1d));      % 状态 x1
x2 = zeros(size(x1d));      % 状态 x2
x10=1;
x20=1;
n=[];
k = 1;
for tt=0:dt:(N-3)*dt
%     dx1 = x20; 
%     e = x10 - x1d(k);                   % 误差 e1
%     de=dx1-dx1d(k);
%     s=c*e+de;
%     ds=-site*sign(s)-m*s;
% %   e2 = x2(k) - x2d(k);                    % 误差 e2
%     u = 1/B*(-A*x20+ddx1d(k)-c*de+ds);             %控制规律                            
%                                % dx1/dt 状态方程1
%     dx2 =-A*x20+B*u;                     %  状态方程2       
%     
%     n=[n;x10];
%     x10 = x10 + dx1 * dt;            % 更新 x1，注意是加上 dx1 * dt 而不是 dx1
%     x20 = x20 + dx2 * dt;            % 更新 x2，注意是加上 dx2 * dt 而不是 dx2
%     
%     k = k + 1;                              % 迭代次数

    dx1 = x2(k);                            % dx1/dt 状态方程1

    e1 = x1(k) - x1d(k);                   % 误差 e1
%     x2d(k)=dx1d(k)-e1;                     %跟踪状态x2d
    de1 = x2(k) - dx1d(k);                    % 误差 e2
    %% 趋近率
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

    
    %% 控制率
%     dx2d =ddx1d(k)-x2(k)+dx1d(k);          % x2d 的一阶导数
%     u = (-e1-e2+A*x2(k)+dx2d)/B;             %控制规律     
%     u = 1.7213*x2(k)-0.7189*x1(k)+ddx1d(k)-c*de1+ds;             %控制规律
     u = 1.7213*x2(k)-0.7189*x1(k)+ddx1d(k)-b*(q/p)*(e1^(q/p-1))*de1+ds;           %终端控制规律

    %%
    
    n=[n;u];
    dx2 =-1.7213*x2(k)+0.7189*x1(k)+u;   %  状态方程2  
    
    
    x1(k+1) = x1(k) + dx1 * dt;            % 更新 x1，注意是加上 dx1 * dt 而不是 dx1
    x2(k+1) = x2(k) + dx2 * dt;            % 更新 x2，注意是加上 dx2 * dt 而不是 dx2
    
    k = k + 1;       
end
    
% subplot(211);
plot(t, x1d, 'LineWidth', 2); hold on                  % 绘制目标曲线
plot(t, real(x1), '-.', 'LineWidth', 2);hold off                          % 绘制实际输出曲线
legend('目标值', '输出值');xlabel('时间 t(s)');ylabel('输出/mm');    % 添加标注
% axis([0 10 -5 5]); % 设置坐标轴在指定的区间
% axis([0 21 -1.5 1.5]);

% subplot(212);plot(t, x2d, 'LineWidth', 2); hold on                  % 绘制目标曲线
% plot(t, x2, '-.', 'LineWidth', 2);hold off                          % 绘制实际输出曲线
% legend('目标值', '输出值');xlabel('时间 t(s)');ylabel('状态 x_2');   % 添加标注
% figure 
ss=real(x1);
l=ss-x1d;
% plot(t,l);
% xlabel('时间 t(s)');ylabel('x1误差');
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
% xlabel('时间 t(s)');ylabel('x2误差');