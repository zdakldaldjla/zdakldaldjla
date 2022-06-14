%建立preisach模型

%written by Y. L. Zhang, Email: iLoveMatlab@gmail.com
%Give you feedbackat: http://www.ilovematlab.cn/thread-55205-1-1.html



%% Let N=10
clear
N=10; %this control the plane size

%generate the alpha-beta plane;
[a b]=meshgrid(-0.5:1/N:0.5,0.5:-1/N:-0.5);


x=-0.5:0.01:0.5;
y=zeros(1,length(x));
x_old=-0.6;
counter=1;
w=1/(N*(N-1))/2;


%x increases
for i=1:1:length(x)
    for j=1:N-1
        for k=1:N-j
            if x(i)>=b(j,k)
                temp=1;
            elseif x(i)<=a(j,k)
                 temp=0;
            else
                if x_old<=a(j,k)
                    temp=0;
                elseif x_old>=b(j,k)
                    temp=1;
                end
            end
            y(counter)=y(counter)+temp*w;
        end
    end
    counter=counter+1;
end
% figure
% % plot(x,y,'r')
x1=x;
y1=y;

%x decreases
x=0.5:-0.01:-0.5;
y=zeros(1,length(x));
x_old=0.6;
counter=1;

for i=1:1:length(x)
    for j=1:N-1
        for k=1:N-j
            if x(i)>=b(j,k)
                temp=1;
            elseif x(i)<=a(j,k)
                 temp=0;
            else
                if x_old<=a(j,k)
                    temp=0;
                elseif x_old>=b(j,k)
                    temp=1;
                end
            end
            y(counter)=y(counter)+temp*w;
        end
    end
    counter=counter+1;
end
figure
plot([x1 x],[y1 y],'r');



%% Let N=100

N=100; %this control the plane size
[a b]=meshgrid(-0.5:1/N:0.5,0.5:-1/N:-0.5);%generate the alpha-beta plane;


x=-0.5:0.01:0.5;
y=zeros(1,length(x));
x_old=-0.6;
counter=1;
w=1/(N*(N-1))/2;

%x increases
for i=1:1:length(x)
    for j=1:N-1
        for k=1:N-j
            if x(i)>=b(j,k)
                temp=1;
            elseif x(i)<=a(j,k)
                 temp=0;
            else
                if x_old<=a(j,k)
                    temp=0;
                elseif x_old>=b(j,k)
                    temp=1;
                end
            end
            y(counter)=y(counter)+temp*w;
        end
    end
    counter=counter+1;
end
% hold on
% plot(x,y,'b')

x1=x;
y1=y;

x=0.5:-0.01:-0.5;
y=zeros(1,length(x));
x_old=0.6;
counter=1;

%x decreases
for i=1:1:length(x)
    for j=1:N-1
        for k=1:N-j
            if x(i)>=b(j,k)
                temp=1;
            elseif x(i)<=a(j,k)
                 temp=0;
            else
                if x_old<=a(j,k)
                    temp=0;
                elseif x_old>=b(j,k)
                    temp=1;
                end
            end
            y(counter)=y(counter)+temp*w;
        end
    end
    counter=counter+1;
end
hold on
plot([x1 x],[y1 y],'b');

legend('N=10', 'N=100');
