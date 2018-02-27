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

freq350 = dataset(:,4);
t24_350 = dataset(:,5);
t25_350 = dataset(:,6);

freq500 = dataset(:,7);
t24_500 = dataset(:,8);
t25_500 = dataset(:,9);

freq800 = dataset(:,10);
t24_800 = dataset(:,11);
t25_800 = dataset(:,12);

freq1000 = dataset(:,13);
t24_1000 = dataset(:,14);
t25_1000 = dataset(:,15);

freq2000 = dataset(:,16);
t24_2000 = dataset(:,17);
t25_2000 = dataset(:,18);

delta_t = [ max(t24_300)-min(t24_300) 
            max(t24_350)-min(t24_350)
            max(t24_500)-min(t24_500)
            max(t24_800)-min(t24_800)
            max(t24_1000)-min(t24_1000)
            max(t24_2000)-min(t24_2000)];
        
freq_array = [300 350 500 800 1000 2000];
        
% freq_array = [  max(freq300) max(freq300)
%                 max(freq350) max(freq350)
%                 max(freq500) max(freq500)
%                 max(freq800) max(freq800)
%                 max(freq1000) max(freq1000)
%                 max(freq2000) max(freq2000)];

scatter(freq_array, delta_t*1000000,100,'LineWidth',2);
axis([0 2000 50 130]);
grid on
grid minor
xlabel('Applied Frequency (Hz)','FontSize', 20);
ylabel('Max Time - Min Time (us)','FontSize', 20);
title('Delta t vs Frequency (Triangle Wave Input)','FontSize', 24);
