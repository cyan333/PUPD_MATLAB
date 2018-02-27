%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose: force a triangle wave into DIO23 as input
%          and trigger at the logic threshold point
%          plot the triangle wave frequency vs the 
%          measured frequency from microcontroller.
%   Copyright (c) 2017 by Shanshan Xie
%   for Pressure Ulcer Prevention project
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

digits(8);

%read from excel file
dataset = xlsread('tri_exp.xlsx', 'Sheet1', 'A2:R80');

freq300 = dataset(:,1);
t24_300 = dataset(:,2);
t25_300 = dataset(:,3); 

delta_t = [max(t24_300) min(t24_300)]

scatter(1000*freq300, 1000*t24_300,100,'filled');
hold on
scatter(1000*freq300, 1000*t25_300,100,'filled');

freq350 = dataset(:,4);
t24_350 = dataset(:,5);
t25_350 = dataset(:,6);
hold on
scatter(1000*freq350, 1000*t24_350,100,'filled');
hold on
scatter(1000*freq350, 1000*t25_350,100,'filled');

freq500 = dataset(:,7);
t24_500 = dataset(:,8);
t25_500 = dataset(:,9);
hold on
scatter(1000*freq500, 1000*t24_500,100,'filled');
hold on
scatter(1000*freq500, 1000*t25_500,100,'filled');

freq800 = dataset(:,10);
t24_800 = dataset(:,11);
t25_800 = dataset(:,12);
hold on
scatter(1000*freq800, 1000*t24_800,100,'filled');
hold on
scatter(1000*freq800, 1000*t25_800,100,'filled');

freq1000 = dataset(:,13);
t24_1000 = dataset(:,14);
t25_1000 = dataset(:,15);
hold on
scatter(1000*freq1000, 1000*t24_1000,100,'filled');
hold on
scatter(1000*freq1000, 1000*t25_1000,100,'filled');

freq2000 = dataset(:,16);
t24_2000 = dataset(:,17);
t25_2000 = dataset(:,18);
hold on
scatter(100*freq2000, 1000*t24_2000,100,'filled');
hold on
scatter(100*freq2000, 1000*t25_2000,100,'filled');

%identity line y=x
x=0:0.5:3.5;
y=x;

hold on
plot(x,y,'b','linewidth',2);

grid on
xlabel('Half Time Period of Applied Frequency (ms)','FontSize', 20);
ylabel('Measured Time (ms)','FontSize', 20);
title('Frequency Sweep under Triangle Input to DIO23','FontSize', 24);
