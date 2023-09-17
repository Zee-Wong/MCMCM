% Subroutine of MCMCM for extracting peak range data

function [dinter]=PeakSelect(x1,x2,dref)

[B1,index1] = min(abs(x1-dref(:,1)));
[B2,index2] = min(abs(x2-dref(:,1)));
dinter=dref(index1:index2,:); 

end

