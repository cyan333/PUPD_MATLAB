%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Week 5 2017/10/13
% Purpose:  Experiment of the accuracy of the measurement 
%           is related to the capacitor values.
%          
%   Copyright (c) 2017 by Shanshan Xie
%   for Pressure Ulcer Prevention project
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%get data from excel
dataset = xlsread('err_cap_res.xlsx', 'capacitor', 'A2:AN13');

c2 = dataset(1,1);
err1 = dataset(:,2);
mean2 = mean(err1);
% scatter(Rfsr_1k./1000, mean_1k,100);

c3 = dataset(1,3);
err2 = dataset(:,4);
mean3 = mean(err2);
% hold on
% scatter(Rfsr_2k./1000, mean_2k,100);

c5 = dataset(1,5);
err3 = dataset(:,6);
mean5 = mean(err3);
% hold on
% scatter(Rfsr_3k./1000, mean_3k,100);

c6 = dataset(1,7);
err6 = dataset(:,8);
mean6 = mean(err6);
% hold on
% scatter(Rfsr_7_5k./1000, mean_7_5k,100);

c7 = dataset(1,9);
err7 = dataset(:,10);
mean7 = mean(err7);
% hold on
% scatter(Rfsr_10k./1000, mean_10k,100);

c11 = dataset(1,11);
err11 = dataset(:,12);
mean11 = mean(err11);
% hold on
% scatter(Rfsr_30k./1000, mean_30k,100);

c20 = dataset(1,13);
err20 = dataset(:,14);
mean20 = mean(err20);
% hold on
% scatter(Rfsr_50k./1000, mean_50k,100);

c30 = dataset(1,15);
err30 = dataset(:,16);
mean30 = mean(err30);
% hold on
% scatter(Rfsr_100k./1000, mean_100k,100);

c40 = dataset(1,17);
err40 = dataset(:,18);
mean40 = mean(err40);

c50 = dataset(1,19);
error50 = dataset(:,20);
mean50 = mean(error50);

c60 = dataset(1,21);
error_60 = dataset(:,22);
mean60 = mean(error_60);

c70 = dataset(1,23);
error_70 = dataset(:,24);
mean70 = mean(error_70);

c100 = dataset(1,25);
error100 = dataset(:,26);
mean100 = mean(error100);

c200 = dataset(1,27);
error200 = dataset(:,28);
mean200 = mean(error200);


c300 = dataset(1,29);
error300 = dataset(:,30);
mean300 = mean(error300);

c400 = dataset(1,31);
error400 = dataset(:,32);
mean400 = mean(error400);


c1000 = dataset(1,33);
error1000 = dataset(:,34);
mean1000 = mean(error1000);

c4700 = dataset(1,35);
error4700 = dataset(:,36);
mean4700 = mean(error4700);

c5700 = dataset(1,37);
error5700 = dataset(:,38);
mean5700 = mean(error5700);


c10000 = dataset(1,39);
error10000 = dataset(:,40);
mean10000 = mean(error10000);

c = [c2 c3 c5 c6 c7 c11 c20 c30 c40 c50 60 c70 c100 c200 c300 c400 c1000 c4700 c5700 c10000];
error1 = [  mean2 
            mean3 
            mean5 
            mean6 
            mean7 
            mean11 
            mean20 
            mean30 
            mean40 
            mean50 
            mean60 
            mean70 
            mean100 
            mean200 
            mean300 
            mean400 
            mean1000 
            mean4700 
            mean5700 
            mean10000];

scatter(c, error1,'LineWidth',2);

%calculation
%Set Test Condition
delta_t = 32e-6;
C = 2e-9:2e-8:10e-6;
Rref = 10000;
Rfsr = 10000;
%Computation Result
error = (delta_t./C)*(1./Rfsr+1/Rref)*100;
hold on
plot(C*1000000000, error, 'LineWidth',2);

% axis([1000 100000 10e-5 10e3]);
% xticks([1000 10000 100000]);
% xticklabels({'1k', '10k', '100k'});

xlabel('Applied Capacitor (nF)','FontSize', 20)
% title('Force Sensitive Resistor vs Error','FontSize', 20)
ylabel('Error (%)','FontSize', 20)
lgd = legend('Measurment','Simulation');
lgd.FontSize = 16;

set(gca,'yscale','log');
set(gca,'xscale','log')

grid on
grid minor






