%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Week 7 2017/10/15
% Purpose:  Investigate the relationship between the 
%           applied resistor and the error
%          
%   Copyright (c) 2017 by Shanshan Xie
%   for Pressure Ulcer Prevention project
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all

dataset1 = xlsread('Week7_multi_cap_2.xlsx', 'all', 'A2:C8');

Rfsr1 = dataset1(:,1);
error1 = dataset1(:,2);
time1 = dataset1(:,3);      

dataset2 = xlsread('Week7_multi_cap_2.xlsx', 'all', 'A10:C16');

Rfsr2 = dataset2(:,1);
error2 = dataset2(:,2);
time2 = dataset2(:,3);    

dataset3 = xlsread('Week7_multi_cap_2.xlsx', 'all', 'A18:C24');

Rfsr3 = dataset3(:,1);
error3 = dataset3(:,2);
time3 = dataset3(:,3); 

dataset4 = xlsread('Week7_multi_cap_2.xlsx', 'all', 'A26:C32');

Rfsr4 = dataset4(:,1);
error4 = dataset4(:,2);
time4 = dataset4(:,3); 

dataset5 = xlsread('Week7_multi_cap_2.xlsx', 'all', 'A34:B40');

Rfsr5 = dataset5(:,1);
error5 = dataset5(:,2);
% time4 = dataset4(:,3); 
figure
% plot(Rfsr1, error1, 'o-','LineWidth',2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% hold on
plot(Rfsr2, error2, 'LineWidth',2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% hold on
% plot(Rfsr3, error3, 'LineWidth',2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% hold on
% plot(Rfsr4, error4, 'LineWidth',2);

% hold on
% plot(Rfsr5, error5, 'LineWidth',2);

grid on 
grid minor

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Rref_sim1 = 10000;
Rref_sim2 = 1000;
Rfsr_1 = 1e3:100:100e3;

% delta_t1 = (0.0066.*Rfsr+54).*0.000001;
delta_t1 = 92e-6;
C1 = 0.5*(0.637e-6+2.25e-6);
t2 = C1*Rfsr_1;
%Computation Result
error_sim1 = (delta_t1./C1).*(1./(Rfsr_1)+1/Rref_sim1)*100;
error = error_sim1./(1-delta_t1./t2);

hold on
plot(Rfsr_1, error,'--', 'LineWidth',2);

Rfsr_1k1 = 1e3:100:100e3;

delta_t1_1k = 92e-6;
C2 = 0.64e-6+2.25e-6;
%Computation Result
error_1k1 = (delta_t1_1k./C2).*(1./Rfsr_1k1+1/Rref_sim2)*100;

% hold on
% loglog(Rfsr_1k1, error_1k1,'--', 'LineWidth',2);

axis([1000 100000 0.1 100]);
xticks([1000 10000 100000]);
xticklabels({'1k','10k', '100k'});
yticks([0.1 1 10 20 50]);
yticklabels({'0.1', '1','10', '20','50'});

grid on 
grid minor
xlabel('Force Sensitive Resistor R_{FSR} (\Omega)','FontSize', 20)
% title('Force Sensitive Resistor vs Error','FontSize', 20)
ylabel('Error (%)','FontSize', 20)
%     
set(gca,'yscale','log');
set(gca,'xscale','log')
lgd = legend('RREF=10k;C=C1','RREF=10k;C=C1+C2','RREF=1k;C=C1','RREF=1k;C=C1+C2');
lgd.FontSize = 16;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% subplot(2,1,2);
% loglog(Rfsr1, time1, 'LineWidth',2);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% hold on
% loglog(Rfsr2, time2, 'LineWidth',2);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% hold on
% loglog(Rfsr3, time3, 'LineWidth',2);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% hold on
% loglog(Rfsr4, time4, 'LineWidth',2);

axis([900 110000 0 500]);
xticks([1000 5000 10000 50000 100000]);
xticklabels({'1k','5k','10k', '50k','100k'});
yticks([0 10 100 500]);
yticklabels({'0', '10', '100','500'});

grid on 
grid minor
xlabel('Force Sensitive Resistor R_{FSR} (\Omega)','FontSize', 20)
% title('Force Sensitive Resistor vs Error','FontSize', 20)
ylabel('Time To Take Measurment (ms)','FontSize', 20);
lgd = legend('RREF=10k;C=C1','RREF=10k;C=C1+C2','RREF=1k;C=C1','RREF=1k;C=C1+C2');
lgd.FontSize = 16;

