%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Week 5 2017/10/13
% Purpose: 
%          
%   Copyright (c) 2017 by Shanshan Xie
%   for Pressure Ulcer Prevention project
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dataset = xlsread('err_cap_res.xlsx', 'resistor1', 'A2:P33');

Rfsr_1k = dataset(1,1);
error_1k = dataset(:,2);
mean_1k = mean(error_1k);
% scatter(Rfsr_1k./1000, mean_1k,100);


Rfsr_2k = dataset(1,15);
error_2k = dataset(:,16);
mean_2k = mean(error_2k);
% hold on
% scatter(Rfsr_2k./1000, mean_2k,100);


Rfsr_3k = dataset(1,3);
error_3k = dataset(:,4);
mean_3k = mean(error_3k);
% hold on
% scatter(Rfsr_3k./1000, mean_3k,100);

Rfsr_7_5k = dataset(1,5);
error_7_5k = dataset(:,6);
mean_7_5k = mean(error_7_5k);
% hold on
% scatter(Rfsr_7_5k./1000, mean_7_5k,100);

Rfsr_10k = dataset(1,7);
error_10k = dataset(:,8);
mean_10k = mean(error_10k);
% hold on
% scatter(Rfsr_10k./1000, mean_10k,100);

Rfsr_30k = dataset(1,9);
error_30k = dataset(:,10);
mean_30k = mean(error_30k);
% hold on
% scatter(Rfsr_30k./1000, mean_30k,100);

Rfsr_50k = dataset(1,11);
error_50k = dataset(:,12);
mean_50k = mean(error_50k);
% hold on
% scatter(Rfsr_50k./1000, mean_50k,100);

Rfsr_100k = dataset(1,13);
error_100k = dataset(:,14);
mean_100k = mean(error_100k);
% hold on
% scatter(Rfsr_100k./1000, mean_100k,100);

Rfsr1 = [Rfsr_1k Rfsr_2k Rfsr_3k Rfsr_7_5k Rfsr_10k Rfsr_30k Rfsr_50k Rfsr_100k];
error1 = [mean_1k mean_2k mean_3k mean_7_5k mean_10k mean_30k mean_50k mean_100k];

% Rfsr1 = [9870
% 99700
% 1964
% 29710
% 989.12];
% error1 = [2.241070497
% 1.50380877
% 20.31236511
% 1.588109482
% 36.63138864];

loglog(Rfsr1, error1,'o','LineWidth',2);

%calculation
%Set Test Condition
delta_t = 60e-6;
C = 640e-9;
Rref = 10000;
Rfsr = 1e3:100:100e3;
%Computation Result
error = (delta_t./C)*(1./Rfsr+1/Rref)*100;
hold on
loglog(Rfsr, error, 'LineWidth',2);

axis([1000 100000 10e-5 10e3]);
xticks([1000 10000 100000]);
xticklabels({'1k', '10k', '100k'});

xlabel('Force Sensitive Resistor R_{FSR} (\Omega)','FontSize', 20)
% title('Force Sensitive Resistor vs Error','FontSize', 20)
ylabel('Error (%)','FontSize', 20)
lgd = legend('Experiment','Simulation');
% lgd.FontSize = 16;

set(gca,'yscale','log');
set(gca,'xscale','log')

grid on







