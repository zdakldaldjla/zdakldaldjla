%����PIģ��

disp =m2;
u = m1;
n =length(u);		%����������ȡֵ����
disp_up =disp(1:n);
u_up =u(1:n);
%�Գ������߽��ж���ʽ���
%P =polyfit(u_up,disp_up,4);
%disp_fit =polyval(P,u_up);
%clear P;
%**************��϶���ӵ��趨****************
r =0:4:40;
%r2 =10:0.54:40;
%r3 =40:1.08:100;
%r1 =100:5:199.53;
%r =[r r2 r3 r1];
%clear r1 r2 r3;
n_r =length(r);
%*************����������С*****************
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
