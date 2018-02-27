function [ mdl ] = creep_lsregression( massInGram, t, R)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here



% creep_behav_phi = 2.7e-11;
% original_stress = 0.011;
strain = ((massInGram/1000)*9.8)/1.27e-4;
% A = (creep_behav_phi*strain)./(1-original_stress);

modelfun = @(a,x)((1-a(1).*x.^a(2)).*exp(-a(3).*(x.^a(2))));

% opts = statset('nlinfit');
% opts.Lower = [0 0 0];

% options = fitoptions('Lower', [0 0 0]);
% options.Lower = [0 0 0];
beta0 = [0.1 0.5 0.2];
mdl = fitnlm(t,R, modelfun, beta0);

% mint = min(t);
% maxt = max(t);
% gridX = linspace(mint, maxt, 100);
% coeffi = mdl.Coefficients(:,1);
% array_coeffi = table2array(coeffi)';
% plot(gridX, modelfun(array_coeffi, gridX), 'r');
% hold on
% y1 = (1+(0.00054177.*(gridX-mint).^(-0.033616))).*exp(1.9209.*((gridX-mint).^(-0.033616)));
% plot(gridX, y1, '-ok');
% hold on
% y = 47*(1-(0.0009518*gridX.^(0.03361))).*exp(-1.92.*(gridX.^(0.03361)));
% 
% plot(gridX, y, '-or');

% (1-(a*x.^n))*exp(-b*(x.^n))*9

end

