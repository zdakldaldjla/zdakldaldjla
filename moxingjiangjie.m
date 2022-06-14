%模型降阶

%% 1.1快照集合
energy=0.999999;
G_X=X;
%% 1.2对快照集合进行奇异值分解
[U_X_1,S_X_1,V_X]=svd(G_X); %U_X_1为正交特征向量U；S_X_1为特征值矩阵且按降序排列；V_X为一个正交矩阵
%% 1.3根据能量值确定最佳正交基
%1.3.1 计算总能量值 
for i=1:size(S_X_1,2)
    zzx(i)=S_X_1(i,i).^2;
end
Zx=sum(zzx); %总能量值
%1.3.2 确定正交基
kkx=2;
for j=1:kkx
    zzzx(j)=S_X_1(j,j).^2;
end
zx=sum(zzzx);
energy_x=zx/Zx;
while energy_x<energy %当所选正交向量所对应的总能占比小于规定值时进行循环
   kkx=kkx+1; 
   for j=1:kkx
    zzzx(j)=S_X_1(j,j).^2;
   end
   zx=sum(zzzx);
   energy_x=zx/Zx;
end
U_X=U_X_1(:,1:kkx); %U_X为最佳正交基
figure();plot(zzzx./Zx,'*');hold on;
%% 2.求系数向量a_X 每一列为一组系数
for i=1:size(X,2)
    for j=1:size(U_X,2)
        a_X(i,j)=dot(U_X(:,j),X(:,i));
    end
end
%% 3.反算验证
px=(a_X*U_X')';
figure();plot(px(:,4));hold on;plot(X(:,4),'r');hold on;
