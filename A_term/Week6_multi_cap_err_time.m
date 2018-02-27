%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Week 6 2017/10/15
% Purpose:  Investigate the relationship between the 
%           applied resistor and the error
%          
%   Copyright (c) 2017 by Shanshan Xie
%   for Pressure Ulcer Prevention project
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dataset = xlsread('week6_multi_cap_err_experiment.xlsx', '6.75uf', 'A2:Q60');

Rfsr_6_75 = [   dataset(1,1)
                dataset(1,4)
                dataset(1,8)
                dataset(1,11)
                dataset(1,13)
                dataset(1,15)];
        
err_6_75 = [    mean(dataset(:,2))
                mean(dataset(:,5))
                mean(dataset(:,9))
                mean(dataset(:,12))
                mean(dataset(:,14))
                mean(dataset(:,16))];
    
Rfsr_6_75_2 = [989.3 9878 99668];
time_6_75 = [   mean(dataset(:,3))
                mean(dataset(:,10))
                mean(dataset(:,17))];

dataset_9 = xlsread('week6_multi_cap_err_experiment.xlsx', '9uf', 'A2:O45');

            
Rfsr_9 = [  dataset_9(1,1)
            dataset_9(1,4)
            dataset_9(1,6)
            dataset_9(1,8)
            dataset_9(1,11)
            dataset_9(1,13)];
        
err_9 = [   mean(dataset_9(:,2))
            mean(dataset_9(:,5))
            mean(dataset_9(:,7))
            mean(dataset_9(:,9))
            mean(dataset_9(:,12))
            mean(dataset_9(:,14))];
    
Rfsr_9_2 = [989.3 9878 99668];
time_9 = [  mean(dataset_9(:,3))
            mean(dataset_9(:,10))
            mean(dataset_9(:,15))];
        
dataset_4_5 = xlsread('week6_multi_cap_err_experiment.xlsx', '4.5uf', 'A2:AA50');

            
Rfsr_4_5 = [  dataset_4_5(1,1)
            dataset_4_5(1,4)
            dataset_4_5(1,7)
            dataset_4_5(1,10)
            dataset_4_5(1,13)
            dataset_4_5(1,16)
            dataset_4_5(1,19)
            dataset_4_5(1,22)
            dataset_4_5(1,25)];
        
err_4_5 = [   mean(dataset_4_5(:,2))
            mean(dataset_4_5(:,5))
            mean(dataset_4_5(:,8))
            mean(dataset_4_5(:,11))
            mean(dataset_4_5(:,14))
            mean(dataset_4_5(:,18))
            mean(dataset_4_5(:,21))
            mean(dataset_4_5(:,23))
            mean(dataset_4_5(:,26))];
    
Rfsr_4_5_2 = [989.3 9878 99668];
time_4_5 = [    mean(dataset_4_5(:,3))
                mean(dataset_4_5(:,15))
                mean(dataset_4_5(:,27))];

dataset_2_25 = xlsread('week6_multi_cap_err_experiment.xlsx', '2.25uf', 'A2:AE70');

            
Rfsr_2_25 = [  dataset_2_25(1,1)
            dataset_2_25(1,4)
            dataset_2_25(1,7)
            dataset_2_25(1,10)
            dataset_2_25(1,13)
            dataset_2_25(1,16)
            dataset_2_25(1,20)
            dataset_2_25(1,24)
            dataset_2_25(1,28)];
        
err_2_25 = [mean(dataset_2_25(:,2))
            mean(dataset_2_25(:,5))
            mean(dataset_2_25(:,8))
            mean(dataset_2_25(:,11))
            mean(dataset_2_25(:,14))
            mean(dataset_2_25(:,18))
            mean(dataset_2_25(:,22))
            mean(dataset_2_25(:,26))
            mean(dataset_2_25(:,30))];
    
Rfsr_2_25_2 = [989.3 9878 99668];
time_2_25 = [    mean(dataset_2_25(:,3))
                mean(dataset_2_25(:,15))
                mean(dataset_2_25(:,31))];
            
dataset_noextra = xlsread('week6_multi_cap_err_experiment.xlsx', 'no_extra', 'A2:AB50');

            
Rfsr_noextra = [dataset_noextra(1,1)
                dataset_noextra(1,4)
                dataset_noextra(1,7)
                dataset_noextra(1,10)
                dataset_noextra(1,13)
                dataset_noextra(1,17)
                dataset_noextra(1,21)
                dataset_noextra(1,25)];
        
err_noextra = [ mean(dataset_noextra(:,2))
                mean(dataset_noextra(:,5))
                mean(dataset_noextra(:,8))
                mean(dataset_noextra(:,11))
                mean(dataset_noextra(:,15))
                mean(dataset_noextra(:,19))
                mean(dataset_noextra(:,23))
                mean(dataset_noextra(:,27))];
    
Rfsr_noextra_2 = [989.3 9878 99668];
time_noextra = [    mean(dataset_noextra(:,3))
                    mean(dataset_noextra(:,16))
                    mean(dataset_noextra(:,28))];

            
% subplot(2,1,1);
% plot(Rfsr_6_75, err_6_75, 'LineWidth',2);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% hold on
% plot(Rfsr_9, err_9, 'LineWidth',2);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% hold on
% plot(Rfsr_4_5, err_4_5, 'LineWidth',2);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% hold on
% plot(Rfsr_2_25, err_2_25, 'LineWidth',2);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% hold on
% plot(Rfsr_noextra, err_noextra, 'LineWidth',2);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Rref = 1000;
Rfsr = 1e3:100:100e3;

% delta_t1 = (0.0066.*Rfsr+54).*0.000001;
delta_t1 = 92e-6;
C1 = 0.64e-6;
%Computation Result
error1 = (delta_t1./C1).*(1./Rfsr+1/Rref)*100;
hold on
% loglog(Rfsr, error1,'--', 'LineWidth',2);

axis([1000 100000 0.1 50]);
xticks([1000 10000 100000]);
xticklabels({'1k','10k', '100k'});
yticks([0.1 1 10 20 50]);
yticklabels({'0.1', '1','10', '20','50'});

grid on 
grid minor
xlabel('Force Sensitive Resistor R_{FSR} (\Omega)','FontSize', 20)
% title('Force Sensitive Resistor vs Error','FontSize', 20)
ylabel('Error (%)','FontSize', 20)
    
% set(gca,'yscale','log');
% set(gca,'xscale','log')
lgd = legend('+3cap','+4cap','+2cap','+1cap','no extra cap','simulation');
lgd.FontSize = 16;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% subplot(2,1,2);
plot(Rfsr_6_75_2, time_6_75, '-','LineWidth',2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
plot(Rfsr_9_2, time_9, 'LineWidth',2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
plot(Rfsr_4_5_2, time_4_5, 'LineWidth',2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
plot(Rfsr_2_25_2, time_2_25, 'LineWidth',2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
plot(Rfsr_noextra_2, time_noextra, 'LineWidth',2);

axis([900 110000 0 1000]);
xticks([1000 5000 10000 50000 100000]);
xticklabels({'1k','5k','10k', '50k','100k'});
yticks([0 10 100 500 1000]);
yticklabels({'0', '10', '100','500','1000'});

grid on 
grid minor
xlabel('Force Sensitive Resistor R_{FSR} (\Omega)','FontSize', 20)
% title('Force Sensitive Resistor vs Error','FontSize', 20)
ylabel('Time To Take Measurment (ms)','FontSize', 20);
lgd = legend('+3cap','+4cap','+2cap','+1cap','no extra cap','simulation');
lgd.FontSize = 16;

