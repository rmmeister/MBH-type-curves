function [ EiOfMinusX ] = approxEi( X )
%EIOFMINUSX Calculates and returns approximation of exponential integral
%function for the minus of the argument.
%   based on DA Barry (2000)

gamma = .57721566490;
G = exp(-gamma);
b = sqrt(2*(1-G)/G/(2-G));
h_inf = (1-G)*(G^2 - 6*G + 12)/3/G/b/(2-G)^2;
q = 20/47*X^(sqrt(31/26));
h = 1/(1+X*sqrt(X)) + h_inf*q/(1+q);
E1ofX = exp(-X)*log(1 + G/X - (1-G)/(h + b*X)^2)/(G+(1-G)*exp(-X/(1-G)));
EiOfMinusX = -E1ofX; 


end

