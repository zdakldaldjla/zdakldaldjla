%ģ�ͽ���

%% 1.1���ռ���
energy=0.999999;
G_X=X;
%% 1.2�Կ��ռ��Ͻ�������ֵ�ֽ�
[U_X_1,S_X_1,V_X]=svd(G_X); %U_X_1Ϊ������������U��S_X_1Ϊ����ֵ�����Ұ��������У�V_XΪһ����������
%% 1.3��������ֵȷ�����������
%1.3.1 ����������ֵ 
for i=1:size(S_X_1,2)
    zzx(i)=S_X_1(i,i).^2;
end
Zx=sum(zzx); %������ֵ
%1.3.2 ȷ��������
kkx=2;
for j=1:kkx
    zzzx(j)=S_X_1(j,j).^2;
end
zx=sum(zzzx);
energy_x=zx/Zx;
while energy_x<energy %����ѡ������������Ӧ������ռ��С�ڹ涨ֵʱ����ѭ��
   kkx=kkx+1; 
   for j=1:kkx
    zzzx(j)=S_X_1(j,j).^2;
   end
   zx=sum(zzzx);
   energy_x=zx/Zx;
end
U_X=U_X_1(:,1:kkx); %U_XΪ���������
figure();plot(zzzx./Zx,'*');hold on;
%% 2.��ϵ������a_X ÿһ��Ϊһ��ϵ��
for i=1:size(X,2)
    for j=1:size(U_X,2)
        a_X(i,j)=dot(U_X(:,j),X(:,i));
    end
end
%% 3.������֤
px=(a_X*U_X')';
figure();plot(px(:,4));hold on;plot(X(:,4),'r');hold on;
