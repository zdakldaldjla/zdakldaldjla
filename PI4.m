%建立PI模型

% clear all;

u=m1;
% plot(u);
%r=0:10:90;
r=0:40/3:40;
n_r=length(r);
yo=zeros(n_r,length(u));
%wb=[0.2841;0.1535;0.1230;0.1535:0.1230;0.0202;0.0638;0.0033;0.0632;0.0370;0.0261;0.0034];
% wb=[0.0493;0;0.0120;0.0090:0;0;0;0;0;0;0;0];
for j=1:1:n_r
    yo(j,1)=max(u(1)-r(j),min(u(1)+r(j),0));
    for i=2:length(u)
        yo(j,i)=max(u(i)-r(j),min(u(i)+r(j),yo(j,i-1)));
    end
end
% disp_model =wb'*y; %%%拟合的位移
% plot(t,disp_model,'b','linewidth',2);
% plot(u,disp_model,'b','linewidth',2);