%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Week 7 2017/10/15
% Purpose:  Investigate the relationship between the 
%           applied resistor and the error
%          
%   Copyright (c) 2017 by Shanshan Xie
%   for Pressure Ulcer Prevention project
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all

%%%%%%%%%%%%%%%Experiment Data From Excel%%%%%%%%%%%%%%%
dataset1 = xlsread('Week7_final_exp.xlsx', 'all', 'A2:C8');

Rfsr1 = dataset1(:,1);
error1 = dataset1(:,2);
time1 = dataset1(:,3);      

dataset2 = xlsread('Week7_final_exp.xlsx', 'all', 'A10:C16');

Rfsr2 = dataset2(:,1);
error2 = dataset2(:,2);
time2 = dataset2(:,3);    

dataset3 = xlsread('Week7_final_exp.xlsx', 'all', 'A18:C24');

Rfsr3 = dataset3(:,1);
error3 = dataset3(:,2);
time3 = dataset3(:,3); 

dataset_real = xlsread('Week7_final_exp.xlsx', 'Sheet1', 'A2:C9');

Rfsr_real = dataset_real(:,1);
error_real = dataset_real(:,2);

%%%%%%%%%%%%%%% Simulation %%%%%%%%%%%%%%%
Rref1 = 1000;
Rref2 = 9862;

Rfsr = 1e3:100:100e3;
delta_t = 92e-6;
C1 = 0.637e-6;
C2 = 0.637e-6+(2.1e-6);
t1_1=C1*Rfsr;
t1_2=C2*Rfsr;
%%%% Rref = 1k 1 extra cap %%%%%
error_sim_1k = (delta_t./(0.5*C2)).*(1./(Rfsr)+1/Rref1)*100;
%%%% extra extra extra
error_1k = error_sim_1k./(1-delta_t./t1_2);
%%%% Rref = 10k 1 extra cap%%%%%
error_sim_10k1 = (delta_t./(0.5*C2)).*(1./(Rfsr)+1/Rref2)*100;
error_10k1 = error_sim_10k1./(1-delta_t./t1_1);
%%%% Rref = 10k no extra cap%%%%%
error_sim_10k2 = (delta_t./(0.5*C1)).*(1./(Rfsr)+1/Rref2)*100;
error_10k2 = error_sim_10k2./(1-delta_t./t1_1);
%%%%%%%%%%%% plot %%%%%%%%%%%%%
figure
subplot(3,1,1);
%%%% Rref = 10k No Extra Cap - Err vs R %%%%%
scatter(Rfsr1, error1,'b','LineWidth',2);
hold on
loglog(Rfsr, error_10k2,'b-', 'LineWidth',2);

set(gca,'yscale','log');
set(gca,'xscale','log')
lgd = legend('Experiment','Simulation');
lgd.FontSize = 16;

grid on
grid minor

axis([900 110000 0.1 50]);
xticks([1000 10000 100000]);
xticklabels({'1k','10k', '100k'});
yticks([0.1 1 10 20 50]);
yticklabels({'0.1', '1','10', '20','50'});
ylabel('Time (ms)','FontSize', 12);

%%%% Rref = 10k 1 Extra Cap - Err vs R %%%%%
subplot(3,1,2);
hold on
scatter(Rfsr2, error2, 'r','LineWidth',2);
hold on
loglog(Rfsr, error_10k1, 'r-','LineWidth',2);

set(gca,'yscale','log');
set(gca,'xscale','log')
lgd = legend('Experiment','Simulation');
lgd.FontSize = 16;

grid on
grid minor

axis([900 110000 0.1 30]);
xticks([1000 10000 100000]);
xticklabels({'1k','10k', '100k'});
yticks([0.1 1 10 20]);
yticklabels({'0.1', '1','10', '20'});
ylabel('Time (ms)','FontSize', 12);

%%%% Rref = 1k 1 Extra Cap - Err vs R %%%%%

subplot(3,1,3);
hold on
scatter(Rfsr3, error3, 'k','LineWidth',2);
hold on
loglog(Rfsr, error_1k,'k-', 'LineWidth',2);

set(gca,'yscale','log');
set(gca,'xscale','log')
lgd = legend('Experiment','Simulation');
lgd.FontSize = 16;

axis([900 110000 1 20]);
xticks([1000 10000 100000]);
xticklabels({'1k','10k', '100k'});
yticks([0.1 1 10 20]);
yticklabels({'0.1', '1','10', '20'});
grid on
grid minor

xlabel(' R_{FSR} (\Omega)','FontSize', 12)
% title('Force Sensitive Resistor vs Error','FontSize', 20)
ylabel('Time (ms)','FontSize', 12);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% Algorithim %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


figure
subplot(2,1,1);

loglog(Rfsr_real,error_real,'ko','LineWidth',2);
%%%% Worst case simulation %%%%

%%%% Rref = 10k No Extra Cap - Err vs R %%%%%
hold on
plot(Rfsr1, error1,'bo-','LineWidth',2);

%%%% Rref = 10k 1 Extra Cap - Err vs R %%%%%
hold on
plot(Rfsr2, error2, 'ro-','LineWidth',2);

%%%% Rref = 1k 1 Extra Cap - Err vs R %%%%%
hold on
plot(Rfsr3, error3, 'ko-','LineWidth',2);

set(gca,'yscale','log');
set(gca,'xscale','log')
grid on
grid minor
axis([900 110000 0.1 50]);
xticks([1000 10000 100000]);
xticklabels({'1k','10k', '100k'});
yticks([0.1 1 10 20]);
yticklabels({'0.1', '1','10', '20'});
ylabel('Error (%)','FontSize', 12);

lgd = legend('Rref=10k C1','Rref=10k C1+C2','Rref=1k C1+C2');


subplot(2,1,2);


loglog(Rfsr1,time1,'bo-','LineWidth',2);

hold on
loglog(Rfsr2,time2,'ro-','LineWidth',2);

hold on
loglog(Rfsr3,time3,'ko-','LineWidth',2);

xlabel(' R_{FSR} (\Omega)','FontSize', 12)
% title('Force Sensitive Resistor vs Error','FontSize', 20)
ylabel('Time (ms)','FontSize', 12);

set(gca,'yscale','log');
set(gca,'xscale','log')
axis([900 110000 30 400]);
xticks([1000 10000 100000]);
xticklabels({'1k','10k', '100k'});
yticks([30 50 100 200 400]);
yticklabels({'30','50','100','200','400'});

lgd = legend('Rref=10k C1','Rref=10k C1+C2','Rref=1k C1+C2');

grid on
grid minor











