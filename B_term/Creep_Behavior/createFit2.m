function [fitresult, gof] = createFit2(t133_R_changed, r133_R_changed)
%CREATEFIT2(T133_R_CHANGED,R133_R_CHANGED)
%  Create a fit.
%
%  Data for 'untitled fit 2' fit:
%      X Input : t133_R_changed
%      Y Output: r133_R_changed
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 08-Dec-2017 01:31:52


%% Fit: 'untitled fit 2'.
[xData, yData] = prepareCurveData( t133_R_changed, r133_R_changed );

% Set up fittype and options.
ft = fittype( '(1-(a*x.^n))*exp(-b*(x.^n))*d', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [0 0 0 0];
opts.StartPoint = [0.547215529963803 0.138624442828679 1000 0.149294005559057];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

% Plot fit with data.
% figure( 'Name', 'untitled fit 2' );
h = plot( fitresult, xData, yData );
legend( h, 'r133_R_changed vs. t133_R_changed', 'untitled fit 2', 'Location', 'NorthEast' );
% Label axes
xlabel t133_R_changed
ylabel r133_R_changed
grid on
% ax = gca;
% ax.YLim = [6,20];
% ax.XLim = [0,0.4];


