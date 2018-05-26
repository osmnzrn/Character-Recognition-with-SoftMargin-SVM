function [LAMBDASbest,SVbest,SGbest,SGM,TOTAL,test] = KernelSMC(T,Y)

N = length(Y);

SGM = []; TOTAL = []; Fbest = inf;

for s = 14.5:0.01:15.5
    
    g = -ones(1,N);
    Aeq = Y';
    beq = 0;
    Aie = eye(N);
    bie = zeros(N,1);

    for i=1:N
        for j=1:N
            H(i,j)=Y(i)*Y(j)*GaussKernel(T(i,:)', T(j,:)',s);
        end
    end

    C = 10;
    ub = C*ones(N,1); 
    [lambdas] = quadprog(H,g,-Aie,-bie,Aeq,beq,[],ub);
    
    SV = find(lambdas>1e-6);
    
    
    YHAT = [];
    
    for i = 1:N
        test = T(i,:)';
        yhat = ModelKernelSMC(test,lambdas,T,Y,s);
        YHAT = [YHAT;yhat];
    end
    
    YHAT = sign(YHAT);
     
    NUMofERR = length(find(YHAT~=Y));
    
    
    NUMofSVs = length(SV);
    SGM = [SGM;s];
    TOTAL = [TOTAL;NUMofERR+NUMofSVs];
    
    if NUMofERR+NUMofSVs<Fbest
        Fbest = NUMofERR+NUMofSVs;
        LAMBDASbest = lambdas;
        SVbest = SV;
        SGbest = s;
    end
    
    disp(['sigma:',num2str(s),' NUMMofERR:', num2str(NUMofERR),' NUMofSVs:' num2str(length(SV))])   

end