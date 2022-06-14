%建立PI模型

disp =m2;
u = m1;
n =length(u);		%初载曲线中取值点数
disp_up =disp(1:n);
u_up =u(1:n);
%对初载曲线进行多项式拟合
%P =polyfit(u_up,disp_up,4);
%disp_fit =polyval(P,u_up);
%clear P;
%**************间隙算子的设定****************
r =0:4:40;
%r2 =10:0.54:40;
%r3 =40:1.08:100;
%r1 =100:5:199.53;
%r =[r r2 r3 r1];
%clear r1 r2 r3;
n_r =length(r);
%*************求解二范数最小*****************
y =0;
H =0;
yH =0;
for i =1:1:n;
      y =max( u_up(i) -r, min( u_up(i) +r, y));
end
t =[];
for i =1:1:length(u)
    y =max( u(i) -r, min( u(i) +r, y));
    t =[t;y]; 
end
yi=t';
