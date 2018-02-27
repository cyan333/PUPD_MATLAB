%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Week 6 2017/10/15
% Purpose:  Investigate the relationship between the 
%           applied resistor and the error
%          
%   Copyright (c) 2017 by Shanshan Xie
%   for Pressure Ulcer Prevention project
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all

dataset1 = xlsread('Week7_triggerpoint_verification.xlsx', 'small_cap', 'P4:S11');

Rfsr1 = dataset1(:,1);
time_avg = dataset1(:,2);
time_max = dataset1(:,3);      
time_min = dataset1(:,4);      

dataset2 = xlsread('Week7_triggerpoint_verification.xlsx', '1cap', 'P4:S11');

Rfsr2 = dataset2(:,1);
time_avg2 = dataset2(:,2);
time_max2 = dataset2(:,3);      
time_min2 = dataset2(:,4);  


plot(Rfsr1, time_avg,'o-', 'LineWidth',2);
hold on
plot(Rfsr2, time_max,'+--', 'LineWidth',2);
hold on
plot(Rfsr2, time_min,'s:', 'LineWidth',2);

hold on
plot(Rfsr2, time_avg2,'o-', 'LineWidth',2);
hold on
plot(Rfsr2, time_max2,'+--', 'LineWidth',2);
hold on
plot(Rfsr2, time_min2,'s:', 'LineWidth',2);

axis([1000 100000 0.1 200]);
xticks([1000 10000 100000]);
xticklabels({'1k','10k', '100k'});
yticks([0.1 1 10 20 50 100 200]);
yticklabels({'0.1', '1','10', '20','50','100','200'});


grid on 
grid minor
xlabel('Force Sensitive Resistor R_{FSR} (\Omega)','FontSize', 20)
% title('Force Sensitive Resistor vs Error','FontSize', 20)
ylabel('time (ms)','FontSize', 20)

lgd = legend('small cap avg','small cap max','small cap min','large cap avg','large cap max','large cap min');
lgd.FontSize = 16;




