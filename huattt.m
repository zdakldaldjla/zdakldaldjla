%��ͼ

% subplot(4,1,1)
% plot(yo(1,:));
% xlabel('��������');ylabel('y1');
% subplot(4,1,2)
% plot(yo(2,:));
% xlabel('��������');ylabel('y2');
% subplot(4,1,3)
% plot(yo(3,:));
% xlabel('��������');ylabel('y3');
% subplot(4,1,4)
% plot(yo(4,:));
% xlabel('��������');ylabel('y4');

% subplot(11,1,5)
% plot(yo(5,:));
% xlabel('��������');%ylabel('y4/mm');
% 
% subplot(11,1,6)
% plot(yo(6,:));
% xlabel('��������');%ylabel('y4/mm');
% 
% subplot(11,1,7)
% plot(yo(7,:));
% xlabel('��������');%ylabel('y4/mm');
% 
% subplot(11,1,8)
% plot(yo(8,:));
% xlabel('��������');%ylabel('y4/mm');
% 
% subplot(11,1,9)
% plot(yo(9,:));
% xlabel('��������');%ylabel('y4/mm');
% 
% subplot(11,1,10)
% plot(yo(10,:));
% xlabel('��������');%ylabel('y4/mm');
% 
% subplot(11,1,11)
% plot(yo(11,:));
% xlabel('��������');%ylabel('y4/mm');


plot(T,h);
dt = 0.01;                  % ʱ����
N =20001;                   % ����
t=0:dt:(N-1)*dt;            	% ʱ��
y3= interp1(T,h,t,'pchip');
hold on;
plot(t,y3)

% y4=y3(1348:end);
