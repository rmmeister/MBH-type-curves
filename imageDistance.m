function [ sqDistance, Area  ] = imageDistance( imageNo, U )
%IMAGEDISTANCE Calculates the distance of each image well to the source
%well.
%   U defines different cases of well positioning inside the
%   reservoir and rectangular reservoir dimensions. These positions are the
%   ones stated in the problem sheet of the Homework.

switch U
    case 2 % well in the center of square drainage
        a = 1; b = 1; Alpha = 1/2; Beta = 1/2;
    case 3 % well in corner of 1:2 rectangle; first case  
        a = 2; b = 1; Alpha = 1/8; Beta = 1/2;
    case 4 % well in corner of 1:2 rectangel; second case
        a = 2; b = 1; Alpha = 1/4; Beta = 1/4;
end
        
Area = a*b;

m = -imageNo:1:imageNo;
n = -imageNo:1:imageNo;
x1 = 2.*m.*a;
x2 = 2.*(m + Alpha).*a;
y1 = 2.*n.*b;
y2 = 2.*(n + Beta).*b;

for i = 1:length(m)
    for j = 1:length(n)
        pointA(i, j) = sqrt(sum(x1(i)^2 + y1(j)^2));
        pointB(i, j) = sqrt(sum(x2(i)^2 + y1(j)^2));
        pointC(i, j) = sqrt(sum(x1(i)^2 + y2(j)^2));
        pointD(i, j) = sqrt(sum(x2(i)^2 + y2(j)^2));
    end
end

distance = [pointA; pointB; pointC; pointD];
sqDistance = sort(nonzeros(distance.^2));
end

