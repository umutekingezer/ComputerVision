%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%              LABORATORY #6 
%%%              COMPUTER VISION 2021-2022
%%%              NON-RIGID STRUCTURE FROM MOTION - OPTIMIZATION 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [Q] = metricUpgrade(LambdaHat,q0)

k = size(LambdaHat,2)/3;
F = size(LambdaHat,1)/2;

if(~exist('q0'))
    q0 = zeros(3*k,3);
    q0(0*k+1,1) = 1;
    q0(1*k+1,2) = 1;
    q0(2*k+1,3) = 1;
end

options = optimset('Diagnostics','off','MaxFunEval',100000,'MaxIter',2000,'TolFun',1e-10,'TolX',1e-10);
[q, fval] = fminunc(@evalQ,q0,options,LambdaHat); 

Q = reshape(q,3*k,3);