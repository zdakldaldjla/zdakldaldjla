%建立PI模型

%Prandtl_Ishlinskii (PI) Play OPerator
%y(t)=Hr[x,y0](t)
%    =max(x(t)-r,min[x(t)+r,y(t-T)])

%T is the sampling period
%y is the output
%x is the input
%r is the control input threshold or the magnitude of the backlash
%developed by math, www.iLoveMatlab.cn


T=0.001; %1 ms

x=-5:0.01:5;
r=0.5;
y=zeros(size(x));

y(1)=max(x(1)-r,min(x(1)+r,0));
for i=2:1:length(x)
        y(i)=max(x(i)-r,min(x(i)+r,y(i-1)));
end;
plot(x,y)


x=5:-0.01:-5;
r=0.5;
y=zeros(size(x));

y(1)=max(x(1)-r,min(x(1)+r,0));
for i=2:1:length(x)    
    y(i)=max(x(i)-r,min(x(i)+r,y(i-1)));
end;
hold on
plot(x,y)

clear all
x=-4:0.01:4;
r=0.5;
y=zeros(size(x));

y(1)=max(x(1)-r,min(x(1)+r,0));
for i=2:1:length(x)    
    y(i)=max(x(i)-r,min(x(i)+r,y(i-1)));
end;
hold on
plot(x,y)



clear all
x=4:-0.01:-4;
r=0.5;
y=zeros(size(x));

y(1)=max(x(1)-r,min(x(1)+r,0));
for i=2:1:length(x)    
    y(i)=max(x(i)-r,min(x(i)+r,y(i-1)));
end;
hold on
plot(x,y)

% web -browser http://www.ilovematlab.cn/thread-23685-1-1.html