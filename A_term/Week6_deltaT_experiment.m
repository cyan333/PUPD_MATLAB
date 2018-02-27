%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Week 4 2017/10/5
% Purpose:  This experiment is to find out the value of ?t 
%           in the error equation (23) by forcing a triangle 
%           signal from function generator to DIO23.
%          
%   Copyright (c) 2017 by Shanshan Xie
%   for Pressure Ulcer Prevention project
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%add the data from excel
dataset = xlsread('week6_added_cap_experiment.xlsx', 'deltaT', 'A2:B32');

frequency = dataset(:,1);
deltaT = dataset(:,2);
figure
scatter(frequency,deltaT,'b','linewidth',2);

grid on
grid minor
xlabel('Applied Frequency (Hz)','FontSize', 20);
ylabel('Maxtime-Mintime (us)','FontSize', 20);
title('Time Delta Measurement','FontSize', 24);





