% MCMCM ---- A Multi-Channel Modified Correlation Method
% Version 1.0   
% Last update: 2023.5.13 
% Developer: Ziyi Wang from Chongqing University, China
% E-mail: wzycsust@163.com 
% *** Please feel free to contact me if you have any problem ***
% *** Question, Bug Report, Discussion, Suggestion are all welcome ***
% *** Below paper should be cited if MCMCM is utilized in your work ***
% *** 
% *** Your citiation really inspires me a lot !!! \(^o^)/ ***


clear, clc;


% Input Parameter Section
% -----------------------------------------------------------------------
% -----------------------------------------------------------------------
p=100; % Number of input signal channels. When p=1, the traditional correlation method is implemented.
name=('C:\Users\Ziyi Wang\Desktop\Experiment\20230510\bh-590-100um-1s-20t.txt'); 
inputfilename=name;
dref=importdata(inputfilename); 
% The test file name is inputted below.
refpeak=[1405,1523];   
testpeak=[1695,1720];
% -----------------------------------------------------------------------
% -----------------------------------------------------------------------


% Ref peak processing
% -----------------------------------------------------------------------
% -----------------------------------------------------------------------
% Internal peak selection
dinter=PeakSelect(refpeak(1),refpeak(2),dref);
% Internal peak de-baseline
dinter(:,2)=Debase(dinter);
% Ref peak selection
dref=PeakSelect(testpeak(1),testpeak(2),dref);
% Ref peak de-baseline
dref(:,2)=Debase(dref);
% Ref peak normalization
dref(:,2)=dref(:,2)/max(dinter(:,2));
dref(:,2)=dref(:,2)+0.01;
[m,n]=size(dref);
% -----------------------------------------------------------------------
% -----------------------------------------------------------------------


% Test peak processing
% -----------------------------------------------------------------------
% -----------------------------------------------------------------------
for i=1:p;
    path=['C:\Users\Ziyi Wang\Desktop\Experiment\20230511\0-',num2str(i),'.txt']; % test file input filepath
%     path=['C:\Users\Ziyi Wang\Desktop\Experiment\20230511\9-6.txt']; % when p=1
%    path=['C:\Users\Ziyi Wang\Desktop\Experiment\20230511\000single\78ppm-590-100um-1s-20t.txt']; % when p=1
    mid=importdata(path);
    dtest=mid;
    
    % test internal peak
    dtestinter=PeakSelect(refpeak(1),refpeak(2),dtest);
    dtestinter(:,2)=Debase(dtestinter);
    
    % test peak 
    dtestpeak=PeakSelect(testpeak(1),testpeak(2),dtest);
    dtestpeak(:,2)=Debase(dtestpeak);

    %dtestpeak(:,i)=dtestpeak(:,i)-min(dtestpeak(:,i))+1;
    dtestpeak(:,2)=dtestpeak(:,2)/max(dtestinter(:,2));
    dtestpeak(:,2)=dtestpeak(:,2)+0.01;
    dtestmatrix(:,i)=dtestpeak(:,2);
end
% -----------------------------------------------------------------------
% -----------------------------------------------------------------------


% % Multi input signal production
% -----------------------------------------------------------------------
% -----------------------------------------------------------------------
cref=dref(:,2);
ctest=zeros(m,1);
for i=1:m;
    mid=1;
    for j=1:p;
        mid=mid*dtestmatrix(i,j);
    end
    ctest(i)=mid;
end
temp1=cref;
temp2=ctest;
% -----------------------------------------------------------------------
% -----------------------------------------------------------------------


% % Lag
% -----------------------------------------------------------------------
% -----------------------------------------------------------------------
c=sum(cref.*ctest);
x=[0];
for i=1:(length(cref)-1);
 cref = [0;cref];
 ctest = [ctest; 0];
 c = [sum(cref.*ctest),c];
 x = [x,i];
end
cref=temp1;
ctest=temp2;
for i=1:(length(cref)-1);
 cref = [cref;0];
 ctest = [0;ctest];
 c = [c, sum(cref.*ctest)];
 x = [-i,x];
end
c=c';
plot(x,c);
% -----------------------------------------------------------------------
% -----------------------------------------------------------------------

max(c)



