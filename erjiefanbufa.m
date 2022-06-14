%二阶反步法

dt = 0.01;                  % 时间间隔
N = 1000;                   % 点数
t=0:dt:(N-1)*dt;            	% 时间

x1d = sin(t);               % 跟踪目标轨迹
dx1d = cos(t);             % 目标轨迹一阶导数
ddx1d =-sin(t);            % 目标轨迹二阶导数
x1 = zeros(size(x1d));      % 状态 x1
x2 = zeros(size(x1d));      % 状态 x2
x2d = x2;                   % 期望的 x2
A=50;
B=0.25;
k = 1;
for tt=0:dt:(N-2)*dt

    e1 = x1d(k) - x1(k);                                        % 误差 e1
    x2d(k) = dx1d(k) - x1(k)^2 + x1(k)^3 + e1;                  % 期望的 x2
    e2 = x2d(k) - x2(k);                                        % 误差 e2
    dx1 = x1(k)^2 - x1(k)^3 + x2(k);                            % dx1/dt 状态方程1
    dx2d = ddx1d(k) + dx1d(k) + dx1* (-2*x1(k)+3*x1(k)^2 -1);   % x2d 的一阶导数
    u = e1 + e2 + dx2d;                                         % 最终的输入
                                                    
    dx2 = u;                                                    % dx2/dt 状态方程2
    x1(k+1) = x1(k) + dx1 * dt;                                 % 更新 x1，注意是加上 dx1 * dt 而不是 dx1
    x2(k+1) = x2(k) + dx2 * dt;                                 % 更新 x2，注意是加上 dx2 * dt 而不是 dx2
    
    k = k + 1;                                                  % 迭代次数
end

    
subplot(211);plot(t, x1d, 'LineWidth', 2); hold on                  % 绘制目标曲线
plot(t, x1, '-.', 'LineWidth', 2);hold off                          % 绘制实际输出曲线
legend('目标值', '输出值');xlabel('时间 t(s)');ylabel('状态 x_1');    % 添加标注

subplot(212);plot(t, x2d, 'LineWidth', 2); hold on                  % 绘制目标曲线
plot(t, x2, '-.', 'LineWidth', 2);hold off                          % 绘制实际输出曲线
legend('目标值', '输出值');xlabel('时间 t(s)');ylabel('状态 x_2'); % 添加标注

figure
plot(t,x1-x1d);