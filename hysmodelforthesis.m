function Y=hys_model_for_thesis()

%number of backlash and deadzone operators
global num_of_backlash num_of_deadzone
num_of_backlash=20;
num_of_deadzone=4;
%backlash and deadzone operators
global backlash deadzone
backlash=linspace(0,2.5,num_of_backlash);
deadzone=linspace(0,15,num_of_deadzone);
W0=ones(1,(num_of_backlash+num_of_deadzone))*0.2;
W0(num_of_backlash+1)=1.1;
W0(num_of_backlash+2)=1.5;
W0(num_of_backlash+3)=0.7;
W0(num_of_backlash+4)=0.9;

% W0=ones(1,(num_of_backlash+num_of_deadzone))*0.2;
% W0(

W=W0;
t=0:0.1:100;
x=sin(t);
X=x(1:length(x)-10);
%Backlash Weight
Wb=W(1,(1:num_of_backlash));

%Deadzone Weight
Wd=W(1,(num_of_backlash+1:num_of_backlash+num_of_deadzone));

%Initilize the backlash output y0, which is NOT y(0), we use y(1) in matlab
%to represent y(0)
% Yb0=zeros(1,num_of_backlash);
global y00

y00=0;

Yb0=y00*ones(1,num_of_backlash);

%Initialize Yb
%Yb=[
%Y11 Y12 Y13 ... Y1N which is basic backlash operator 1
%Y21 Y22 Y23 ... Y2N which is basic backlash operator 2
%.......................................................................]

Yb=zeros(num_of_backlash,length(X));

%Initilize Y(i1) for each backlash operator, which we call y(0) in the paper
for i=1:num_of_backlash
    Yb(i,1)=max(X(1)-backlash(i), min(X(1)+backlash(i),Yb0(i)));
end

%find the rest of Yb elements
for j=1:num_of_backlash
    for i=2:length(X) %iteration of X
       Yb(j,i)=max(X(i)-backlash(j),min(X(i)+backlash(j),Yb(j,i-1)));
    end
end

%put the weight on Yb
for k=1:num_of_backlash
    Yb(k,:)=Wb(k)* Yb(k,:);
end

%sum each colum of Yb is the real backlash superposition value
A=sum(Yb);
figure
plot(X,A,'k','linewidth',1)
%Now treat A as the input, find the deadzone output
%First, find the basic deadzone operator
Yd=zeros(num_of_deadzone,length(X));

for j=1:num_of_deadzone
    for i=1:length(X)
        if deadzone(j)>0
            Yd(j,i)=max(A(i)-deadzone(j),0);
        elseif deadzone(j)==0;
            Yd(j,i)=A(i);
        else
            Yd(j,i)=min(A(i)-deadzone(j),0); %which should be impossible if we choose deadzone>0
        end
    end
end

%put the deadzone weight on Yd
for k=1:num_of_deadzone
    Yd(k,:)=Wd(k)* Yd(k,:);
end

Y=sum(Yd);
hold on
plot(X,Y,'color',[0.73 0.73 0.73],'linewidth',1')
xlabel('Input');
ylabel('Output');
legend('PI model','Modified PI model','location','best');

% hold on
% 
% plot(X,X,'k:')










