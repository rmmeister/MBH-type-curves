%% INITIALIZE MATLAB
clear all
clc
close all
format long

% INCREMENTS
tpDA = .01:.01:10;
U = input('Enter reservoir shape: \n 1 for CIRCULAR,\n 2 for SQUARE,\n 3 or 4 for first or second RECTANGULAR type');

%% CIRCULAR RESERVOIR

% find roots of bessel function J1
for i=1:100
    guess = 2.5505 + 1.2474*1 + (i-1)*pi;
    x(i) = fzero(@(z) besselj(1, z),guess);
end

% find bessel function J0 at the roots of J1
for i = 1:100
    J0(i) = besselj(0, x(i));
end

% Calculate PD,MBH for circular reservoir
for i = 1:length(tpDA)

    PD_c(i) = 3/2 + log(4*pi*tpDA(i)) - .5772 + 4*sum(exp(-x.^2.*pi.*tpDA(i))...
        ./x.^2./J0.^2);
end

%% NON-CIRCULAR DRAINAGE AREA

if U ~= 1
    % Creating image wells and calculating squared distance from the source
    imageLayers = 10;
    [ sqDistance, Area  ] = imageDistance( imageLayers, U );
    
    % Calculating PD,MBH
    for i = 1:length(tpDA)
        eiTerm = 0;
        for j = 1:length(sqDistance)
            X(i, j) = sqDistance(j)/4/tpDA(i)/Area;
            eiTerm = approxEi(X(i, j)) + eiTerm;
        end
        PD_rect(i) = 4*pi*tpDA(i) + eiTerm;
    end
end
%% Results

if U == 1;
    figure
    semilogx(tpDA, PD_c, 'k', 'LineWidth', 2); grid on
    title('MBH plot for a Circular Reservoir');
    ylabel('P_{D,MBH}');
    xlabel('t_{pDA}');
else
    figure
    semilogx(tpDA, PD_rect, 'k', 'LineWidth', 2); grid on
    title('MBH plot for a Rectangular Reservoir');
    ylabel('P_{D,MBH}');
    xlabel('t_{pDA}');
end