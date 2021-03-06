function [fitresult, gof] = createFit_R_R0(t133_R_changed, r133_R_R0_changed)
%CREATEFIT3(T133_R_CHANGED,R133_R_R0_CHANGED)
%  Create a fit.
%
%  Data for 'untitled fit 1' fit:
%      X Input : t133_R_changed
%      Y Output: r133_R_R0_changed
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 11-Dec-2017 22:32:55


%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( t133_R_changed, r133_R_R0_changed );

% Set up fittype and options.
ft = fittype( '(1-(a*x.^n))*exp(-b*(x.^n))', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [0 0 0];
opts.Robust = 'LAR';
opts.StartPoint = [0.870258033173386 0.970592781760616 0.485375648722841];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

% Plot fit with data.
figure( 'Name', 'untitled fit 1' );
h = plot( fitresult, xData, yData );
legend( h, 'r133_R_R0_changed vs. t133_R_changed', 'untitled fit 1', 'Location', 'NorthEast' );
% Label axes
xlabel t133_R_changed
ylabel r133_R_R0_changed
grid on


