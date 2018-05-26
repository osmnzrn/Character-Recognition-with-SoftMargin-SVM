clear all
close all
warning off
clc

load imgData.mat T Y MinT MaxT

T = T';  %Y = Y';

LAMBDASbest = [];  SVbest = [];  SGbest = [];

binarySVM =2;
for i = 1:binarySVM
    X = Y(:,i);
    
    [LAMBDA,SV,SG,SGM,TOTAL,test] = KernelSMC(T,X);
    
    LAMBDASbest = [LAMBDASbest  LAMBDA];
    SGbest = [SGbest SG];
    SVbest = [SVbest length(SV)];
    
end
save SVMBEST.mat LAMBDASbest SVbest SGbest SV T Y MinT MaxT

plot(SGM,TOTAL)
xlabel('\sigma')
ylabel('NUMofERR+NUMofSVs')
set(gcf,'color',[1 1 1])
set(gcf,'Position', [348 42 804 738])