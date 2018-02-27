clc;clear;close all;

% Uncomment these to generate graphs of new .csv files
% plotData function parses and converts the data in the .csv file

% [t,volt,weight] = plotData('Mem_Test_Rest.csv');
% [t2,volt2,weight2] = plotData('Mem_Test_No_Rest.csv');
% save('Test_Memory');

% If not making changes to .csv files, just load memory
load('Test_Memory');

% Display test with rests
figure(1)
width = 2;
subplot(2,1,1);
plot(t,weight,'LineWidth',width);
ax = gca;
ax.YLim = [0,300];
ax.XLim = [0,40];
grid on
title('8/22/2017 FSR Memory Test with Rest');
xlabel('Time (minutes)');
ylabel('Force (grams)');

subplot(2,1,2);
plot(t,volt,'LineWidth',width);
ax = gca;
ax.YLim = [0,10];
ax.XLim = [0,40];
grid on
title('8/22/2017 FSR Memory Test with Rest');
xlabel('Time (minutes)');
ylabel('Resistance (k\Omega)');

% figure(2)
x = t(1000:60119);
y = volt(1000:60119);

% x = [0 0.5077 0.5698 0.6562 0.7867 0.8995 1.013 1.175 1.385 1.606 1.922 2.111 2.281 2.531 3.081 3.594 4.717 9.853];
% y = [10 7.132 7.065 6.999 6.934 6.87 6.806 6.743 6.681 6.62 6.56 6.5 6.441 6.383 6.325 6.268 6.156 6.047];
% f = fit(x,y,'exp2');
% try2fit = 6.04+1.96*exp((-(x-0.1))./1.4);
% plot(x,y);
% hold on
% plot(x,try2fit);
% ax = gca;
% ax.YLim = [6,8];
% ax.XLim = [0,10];
% grid on
% grid minor

figure(2)
x1 = t(121490:180125);
y1 = volt(121490:180125);
try2fit = 4+2*exp((-(x1-20.14))./1.0);
plot(x1,y1);
hold on
plot(x1,try2fit);
% ax = gca;
% ax.YLim = [3,6];
% ax.XLim = [20,30];
grid on
grid minor

%Derivative
% dt = diff(t);
% dv = diff(volt);
% dvdt = dv./dt;
% 
% subplot(2,1,1);
% plot(t(2:end),dvdt,'LineWidth',width);
% ax = gca;
% ax.YLim = [-800,800];
% ax.XLim = [0,80];
% grid on
% title('8/22/2017 FSR Memory Test with Rest');
% xlabel('Time (minutes)');
% ylabel('Force (grams)');

% Display test with no rests
% figure(2)
% width = 2;
% subplot(2,1,1);
% plot(t2,weight2,'LineWidth',width);
% ax = gca;
% ax.YLim = [0,300];
% ax.XLim = [0,80];
% grid on
% title('8/21/2017 FSR Memory Test No Rest');
% xlabel('Time (minutes)');
% ylabel('Force (grams)');
% 
% subplot(2,1,2);
% plot(t2,volt2,'LineWidth',width);
% ax = gca;
% ax.YLim = [2.3,9.3];
% ax.XLim = [0,80];
% grid on
% title('8/21/2017 FSR Memory Test No Rest');
% xlabel('Time (minutes)');
% ylabel('Resistance (k\Omega)');
% 
% % Display both tests on top of each other
% figure(3)
% width = 2;
% subplot(2,1,1);
% plot(t2,weight2,'LineWidth',width);
% hold on
% plot(t,weight,'LineWidth',width);
% ax = gca;
% ax.YLim = [0,300];
% ax.XLim = [0,80];
% grid on
% title('FSR Memory Test Combined');
% xlabel('Time (minutes)');
% ylabel('Force (grams)');
% 
% subplot(2,1,2);
% plot(t2,volt2,'LineWidth',width);
% hold on
% plot(t,volt,'LineWidth',width);
% hold off
% ax = gca;
% ax.YLim = [2.3,9.3];
% ax.XLim = [0,80];
% grid on
% title('FSR Memory Test Combined');
% xlabel('Time (minutes)');
% ylabel('Resistance (k\Omega)');
% 
% % Display both tests on top of each other with a logarithmic Y axis
% figure(4)
% width = 2;
% subplot(2,1,1);
% plot(t2,weight2,'LineWidth',width);
% hold on
% plot(t,weight,'LineWidth',width);
% ax = gca;
% ax.YLim = [0,300];
% ax.XLim = [0,80];
% grid on
% title('FSR Memory Test Combined Log Y axis');
% xlabel('Time (minutes)');
% ylabel('Force (grams)');
% 
% subplot(2,1,2);
% semilogy(t2,volt2,'LineWidth',width);
% hold on
% semilogy(t,volt,'LineWidth',width);
% hold off
% ax = gca;
% ax.YLim = [2.3,9.3];
% ax.XLim = [0,80];
% grid on
% title('FSR Memory Test Combined');
% xlabel('Time (minutes)');
% ylabel('Resistance (k\Omega)');