function [ K ] = GaussKernel( u, v, s )

K = exp(-(norm(u-v))^2/(2*s^2)) ;



end

