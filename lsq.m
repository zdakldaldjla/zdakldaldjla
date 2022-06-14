%递推最小二乘法

% clc;
% clear;
% load data.txt;
% u=data(:,1);%input
% y=data(:,2);%output
u=m1;
y=m2;
n=2;
N=-n;  %N为数据长度－n
r=2;

for i=1:N        %用最小二乘法初步估计a1,a2,b1,b2
    Y(i,1)=y(i+n);
    Si(i,1)=y(i+1);
    Si(i,2)=y(i);
    Si(i,3)=u(i+1);
    Si(i,4)=u(i);
end
sita =inv(Si'*Si)*Si'*Y;
sitaN=sita;

%用广义最小二乘法求sita
deta = 1.0;
num=0;
while(deta>0.001)
    num=num+1;
    vn=Y-Si*sitaN;
    for i=1:N
        VN(1+i)=vn(i);
    end
    for i=2:N             
      BN(i,1)=VN(i);    
      BN(i,2)=VN(i-1);  
    end
    NN=eye(1483)-Si*inv(Si'*Si)*Si';
    D=BN'*NN*BN;
    fgu=inv(D)*BN'*NN*Y;
    sitaN1=sitaN-inv(Si'*Si)*Si'*BN*fgu;
    deta=norm(sitaN1-sitaN)/norm(sitaN);
    sitaN=sitaN1;
end
sitaN
num
