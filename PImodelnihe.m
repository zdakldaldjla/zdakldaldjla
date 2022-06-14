%画PI迟滞环

T=0.001; %1 ms
x=0:0.01:7;
num_of_backlash=15;
y00=0;

Yb0=y00*ones(1,num_of_backlash);
Yb=zeros(num_of_backlash,length(x));
% Yb1=zeros(num_of_backlash,length(x));
backlash=[0 0.25 0.5 1 2 3 4 5.33 10.67 16 21.33 26.67 32 37.33 42.67]
Wb=[0.3101 0.1539 0.1223 0.0827 0.0655 0.0414 0.0438 0.0202 0.0213 0.0042 0.0336 0.0113 0.0313 0.0207 0.0123]
% Wb=[1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]
%Initilize Y(i1) for each backlash operator, which we call y(0) in the
%paperYb()
for i=1:num_of_backlash
    Yb(i,1)=max(x(1)-backlash(i), min(x(1)+backlash(i),Yb0(i)));
end

%find the rest of Yb elements
for j=1:num_of_backlash
    for i=2:length(x) %iteration of X
       Yb(j,i)=max(x(i)-backlash(j),min(x(i)+backlash(j),Yb(j,i-1)));
    end
end

%put the weight on Yb
for k=1:num_of_backlash
    Yb(k,:)=Wb(k)* Yb(k,:);
end
%sum each colum of Yb is the real backlash superposition value
A1=sum(Yb);
figure
plot(x,A1,'k','linewidth',2)

% ”画回程段“

x=7:-0.01:0;
num_of_backlash=15;
y00=0;

Yb0=y00*ones(1,num_of_backlash);
Yb=zeros(num_of_backlash,length(x));

for i=1:num_of_backlash
    Yb(i,1)=max(x(1)-backlash(i), min(x(1)+backlash(i),Yb0(i)));
end

%find the rest of Yb elements
for j=1:num_of_backlash
    for i=2:length(x) %iteration of X
       Yb(j,i)=max(x(i)-backlash(j),min(x(i)+backlash(j),Yb(j,i-1)));
    end
end

%put the weight on Yb
for k=1:num_of_backlash
    Yb(k,:)=Wb(k)* Yb(k,:);
end
%sum each colum of Yb is the real backlash superposition value
A2=sum(Yb);
hold on
plot(x,A2,'k','linewidth',2)


% 第二个迟滞环

x=0:0.01:6;
num_of_backlash=15;
y00=0;

Yb0=y00*ones(1,num_of_backlash);
Yb=zeros(num_of_backlash,length(x));
backlash=[0 0.25 0.5 1 2 3 4 5.33 10.67 16 21.33 26.67 32 37.33 42.67]
Wb=[0.3101 0.1539 0.1223 0.0827 0.0655 0.0414 0.0438 0.0202 0.0213 0.0042 0.0336 0.0113 0.0313 0.0207 0.0123]
% Wb=[1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]
%Initilize Y(i1) for each backlash operator, which we call y(0) in the
%paperYb()
for i=1:num_of_backlash
    Yb(i,1)=max(x(1)-backlash(i), min(x(1)+backlash(i),Yb0(i)));
end

%find the rest of Yb elements
for j=1:num_of_backlash
    for i=2:length(x) %iteration of X
       Yb(j,i)=max(x(i)-backlash(j),min(x(i)+backlash(j),Yb(j,i-1)));
    end
end

%put the weight on Yb
for k=1:num_of_backlash
    Yb(k,:)=Wb(k)* Yb(k,:);
end
%sum each colum of Yb is the real backlash superposition value
A3=sum(Yb);
hold on
plot(x,A3,'r','linewidth',2)


%画回程段

x=6:-0.01:0;
num_of_backlash=15;
y00=0;

Yb0=y00*ones(1,num_of_backlash);
Yb=zeros(num_of_backlash,length(x));

for i=1:num_of_backlash
    Yb(i,1)=max(x(1)-backlash(i), min(x(1)+backlash(i),Yb0(i)));
end

%find the rest of Yb elements
for j=1:num_of_backlash
    for i=2:length(x) %iteration of X
       Yb(j,i)=max(x(i)-backlash(j),min(x(i)+backlash(j),Yb(j,i-1)));
    end
end

%put the weight on Yb
for k=1:num_of_backlash
    Yb(k,:)=Wb(k)* Yb(k,:);
end
%sum each colum of Yb is the real backlash superposition value
A4=sum(Yb);
hold on
plot(x,A4,'r','linewidth',2)







% 第三个迟滞环

x=0:0.01:5;
num_of_backlash=15;
y00=0;

Yb0=y00*ones(1,num_of_backlash);
Yb=zeros(num_of_backlash,length(x));

for i=1:num_of_backlash
    Yb(i,1)=max(x(1)-backlash(i), min(x(1)+backlash(i),Yb0(i)));
end

%find the rest of Yb elements
for j=1:num_of_backlash
    for i=2:length(x) %iteration of X
       Yb(j,i)=max(x(i)-backlash(j),min(x(i)+backlash(j),Yb(j,i-1)));
    end
end

%put the weight on Yb
for k=1:num_of_backlash
    Yb(k,:)=Wb(k)* Yb(k,:);
end
%sum each colum of Yb is the real backlash superposition value
A3=sum(Yb);
hold on
plot(x,A3,'b','linewidth',2)


%画回程段

x=5:-0.01:0;
num_of_backlash=15;
y00=0;

Yb0=y00*ones(1,num_of_backlash);
Yb=zeros(num_of_backlash,length(x));

for i=1:num_of_backlash
    Yb(i,1)=max(x(1)-backlash(i), min(x(1)+backlash(i),Yb0(i)));
end

%find the rest of Yb elements
for j=1:num_of_backlash
    for i=2:length(x) %iteration of X
       Yb(j,i)=max(x(i)-backlash(j),min(x(i)+backlash(j),Yb(j,i-1)));
    end
end

%put the weight on Yb
for k=1:num_of_backlash
    Yb(k,:)=Wb(k)* Yb(k,:);
end
%sum each colum of Yb is the real backlash superposition value
A4=sum(Yb);
hold on
plot(x,A4,'b','linewidth',2)


















