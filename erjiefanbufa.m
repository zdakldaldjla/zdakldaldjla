%���׷�����

dt = 0.01;                  % ʱ����
N = 1000;                   % ����
t=0:dt:(N-1)*dt;            	% ʱ��

x1d = sin(t);               % ����Ŀ��켣
dx1d = cos(t);             % Ŀ��켣һ�׵���
ddx1d =-sin(t);            % Ŀ��켣���׵���
x1 = zeros(size(x1d));      % ״̬ x1
x2 = zeros(size(x1d));      % ״̬ x2
x2d = x2;                   % ������ x2
A=50;
B=0.25;
k = 1;
for tt=0:dt:(N-2)*dt

    e1 = x1d(k) - x1(k);                                        % ��� e1
    x2d(k) = dx1d(k) - x1(k)^2 + x1(k)^3 + e1;                  % ������ x2
    e2 = x2d(k) - x2(k);                                        % ��� e2
    dx1 = x1(k)^2 - x1(k)^3 + x2(k);                            % dx1/dt ״̬����1
    dx2d = ddx1d(k) + dx1d(k) + dx1* (-2*x1(k)+3*x1(k)^2 -1);   % x2d ��һ�׵���
    u = e1 + e2 + dx2d;                                         % ���յ�����
                                                    
    dx2 = u;                                                    % dx2/dt ״̬����2
    x1(k+1) = x1(k) + dx1 * dt;                                 % ���� x1��ע���Ǽ��� dx1 * dt ������ dx1
    x2(k+1) = x2(k) + dx2 * dt;                                 % ���� x2��ע���Ǽ��� dx2 * dt ������ dx2
    
    k = k + 1;                                                  % ��������
end

    
subplot(211);plot(t, x1d, 'LineWidth', 2); hold on                  % ����Ŀ������
plot(t, x1, '-.', 'LineWidth', 2);hold off                          % ����ʵ���������
legend('Ŀ��ֵ', '���ֵ');xlabel('ʱ�� t(s)');ylabel('״̬ x_1');    % ��ӱ�ע

subplot(212);plot(t, x2d, 'LineWidth', 2); hold on                  % ����Ŀ������
plot(t, x2, '-.', 'LineWidth', 2);hold off                          % ����ʵ���������
legend('Ŀ��ֵ', '���ֵ');xlabel('ʱ�� t(s)');ylabel('״̬ x_2'); % ��ӱ�ע

figure
plot(t,x1-x1d);