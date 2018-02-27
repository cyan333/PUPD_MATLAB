%Week 4 Simulation Result and Calculation Result
%Improvement of last week analysis
clear all
clc
delta_t1 = 32e-6;
delta_t2 = 92e-6;
C = 637e-9;
Rref = 1e4;
Rfsr = 1e3:10:100e3;
% Simulation
% t1 = 10e-7:1e-4:10e-5;
% t2 = 10e-6*ones(1,length(t1));
% Ideal_time_ratio = t1./t2;
 
Ideal_time_ratio = Rfsr./Rref;
t1 = 0.5*C*Rfsr;
t2 = 0.5*C*Rref*ones(1,length(t1));

rand_delta_t1 = 31e-6*rand(1,length(t1));
rand_delta_t2 = 31e-6*rand(1,length(t1));

t2_wError = t2 - rand_delta_t2;
t1_wError = t1 + rand_delta_t1;
timeRatio_wError = t1_wError./t2_wError;

% +/- Error
Error_sim1 = ((timeRatio_wError./Ideal_time_ratio)-1)*100;
Error_sim2 = (1-(timeRatio_wError./Ideal_time_ratio))*100;
 
error = (delta_t1./(0.5*C))*(1./Rfsr+1/Rref)*100;
error1 = (delta_t2./(0.5*C))*(1./Rfsr+1/Rref)*100;
error11 = error1./(1-delta_t2./(C*Rfsr));

%error2 = (delta_t3./C)*(1./Rfsr+1/Rref)*100;
set(0,'defaultaxesfontsize',12)
set(0, 'defaultAxesfontweight', 'bold')
figure1=figure(1)
grid on
semilogx(Rfsr, error,'--k', 'LineWidth',3);
xlabel('R_{FSR} (K\Omega)')
set(gca,'XTick',[1 1000 10000 100000])
set(gca,'XtickLabel',{'1','1', '10', '100'})
%title('Force Sensitive Resistor vs Error')
ylabel('Error (%)')
hold on
semilogx(Rfsr, -error,'--k', 'LineWidth',3);
grid on
grid minor
hold on
semilogx(Rfsr, error11,'-k', 'LineWidth',3);
hold on
semilogx(Rfsr, -error11,'-k', 'LineWidth',3);
SZ = 5%linspace(1,1,1);
hold on
scatter(Ideal_time_ratio*Rref, Error_sim1,SZ,'r');
hold on
scatter(Ideal_time_ratio*Rref,Error_sim2,SZ, 'r');

% lgd = legend('Experiment','Simulation');
% lgd.FontSize = 16;



% Annotate
 text(3500,5,'WORST CASE ERROR', ...
     'BackgroundColor',[1 1 1],'FontSize',13)
 plot([30000 60000],[5 5],'-','Color',[0 0 0 ],'LineWidth',3)
 text(3500,4,'SIMULATED ERROR', ...
    'BackgroundColor',[1 1 1],'FontSize',13)
 plot([30000 40000],[4 4],'o','Color',[1 0 0 ],'LineWidth',2)
 plot([50000 60000],[4 4],'o','Color',[1 0 0 ],'LineWidth',2)

 text(3500,30,'Error for \Deltat_{MAX}', ...
     'BackgroundColor',[1 1 1],'FontSize',13)
 plot([15000 50000],[17 17],'-','Color',[0 0 0 ],'LineWidth',3)

 text(3500,13,'Error for \Deltat_{TYP}', ...
     'BackgroundColor',[1 1 1],'FontSize',13)
 plot([15000 55000],[13 13],'--','Color',[0 0 0 ],'LineWidth',3)
 text(3500,9,'SIMULATED ERROR', ...
    'BackgroundColor',[1 1 1],'FontSize',13)
 plot([25000 35000],[9 9],'o','Color',[1 0 0 ],'LineWidth',2)
 plot([45000 45000],[9 9],'o','Color',[1 0 0 ],'LineWidth',2)
 
 
%saveas(figure1,'loglog.jpeg')
%saveas(figure1,'error_analysis.pdf')