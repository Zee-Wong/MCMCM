% Subroutine of MCMCM for debase the Raman spectrum

function [temp]=Debase(dinter)

X1=[dinter(1,1),dinter(end,1)];
X2=[dinter(1,2),dinter(end,2)];
k=polyfit(X1,X2,1);  
dbase=dinter(:,1)*k(1)+k(2);
temp=dinter(:,2)-dbase;

end