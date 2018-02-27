
clc;clear;close all;

load('Reset_R_R0_changed');
stress = 10263;
a = 0.040/stress;
b = 2.1/stress;
n = 0.02358;

d133 = 57.62;
d174 = 74.8;
d215 = 117.8;
d255 = 187;

stress_now = 10263;
x = linspace(0,10,10000);
y = d133*(1-(a.*stress_now.*x.^n)).*exp(-(b.*stress_now).*(x.^n));
%curve fit fxn: d*(1-(3.89e-6*19677*x.^0.02358))*exp(-(0.000205*19677)*(x.^0.02358))

figure(1)
subplot(2,2,1);
plot(t133_R_changed, r133_R_changed,'r','linewidth', 2);
title('133g');
ylabel('R (k-ohm)');
xlabel('Time(min)');
subplot(2,2,2);
plot(t174_R_changed, r174_R_changed,'r','linewidth', 2);
title('174g');
ylabel('R (k-ohm)');
xlabel('Time(min)');
subplot(2,2,3);
plot(t215_R_changed, r215_R_changed,'r','linewidth', 2);
title('215g');
ylabel('R (k-ohm)');
xlabel('Time(min)');
subplot(2,2,4);
plot(t255_R_changed, r255_R_changed,'r','linewidth', 2);
title('255g');
ylabel('R (k-ohm)');
xlabel('Time(min)');

subplot(2,2,1);
hold on
plot(x, y,'b','linewidth', 2);
ax = gca;
ax.YLim = [5,20];
ax.XLim = [0,1];
grid on 
grid minor

subplot(2,2,2);
hold on
stress_now = 13427;
y = d174*(1-(a.*stress_now.*x.^n)).*exp(-(b.*stress_now).*(x.^n));
plot(x, y,'b','linewidth', 2);
ax = gca;
ax.YLim = [0,10];
ax.XLim = [0,1];
grid on 
grid minor

subplot(2,2,3);
hold on
stress_now = 16591;
y = d215*(1-(a.*stress_now.*x.^n)).*exp(-(b.*stress_now).*(x.^n));
plot(x, y,'b','linewidth', 2);
ax = gca;
ax.YLim = [0,10];
ax.XLim = [0,1];
grid on 
grid minor

subplot(2,2,4);
hold on
stress_now = 19677;
y = d255*(1-(a.*stress_now.*x.^n)).*exp(-(b.*stress_now).*(x.^n));
plot(x, y,'b','linewidth', 2);
ax = gca;
ax.YLim = [0,10];
ax.XLim = [0,1];

grid on 
grid minor

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2)
plot(t133_R_changed, r133_R_changed,'r','linewidth', 2);
hold on
plot(t174_R_changed, r174_R_changed,'b','linewidth', 2);
hold on
plot(t215_R_changed, r215_R_changed,'k','linewidth', 2);
hold on
plot(t255_R_changed, r255_R_changed,'y','linewidth', 2);

ax = gca;
ax.YLim = [0,20];
ax.XLim = [0,5];
grid on
grid minor

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(4)
stress_now = 10263;
y = d133*(1-(a.*stress_now.*x.^n)).*exp(-(b.*stress_now).*(x.^n));
plot(x, y,'r','linewidth', 2);
hold on
stress_now = 13427;
y = d133*(1-(a.*stress_now.*x.^n)).*exp(-(b.*stress_now).*(x.^n));
plot(x, y,'b','linewidth', 2);
hold on
stress_now = 16591;
y = d133*(1-(a.*stress_now.*x.^n)).*exp(-(b.*stress_now).*(x.^n));
plot(x, y,'k','linewidth', 2);
hold on
stress_now = 19677;
y = d133*(1-(a.*stress_now.*x.^n)).*exp(-(b.*stress_now).*(x.^n));
plot(x, y,'y','linewidth', 2);
ax = gca;
ax.YLim = [0,20];
ax.XLim = [0,5];
grid on
grid minor

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(3)
subplot(2,2,1);
plot(t133_R_changed, r133_R_changed,'r','linewidth', 2);
title('133g');
ylabel('R (k-ohm)');
xlabel('Time(min)');
subplot(2,2,2);
plot(t174_R_changed, r174_R_changed,'r','linewidth', 2);
title('174g');
ylabel('R (k-ohm)');
xlabel('Time(min)');
subplot(2,2,3);
plot(t215_R_changed, r215_R_changed,'r','linewidth', 2);
title('215g');
ylabel('R (k-ohm)');
xlabel('Time(min)');
subplot(2,2,4);
plot(t255_R_changed, r255_R_changed,'r','linewidth', 2);
title('255g');
ylabel('R (k-ohm)');
xlabel('Time(min)');

subplot(2,2,1);
stress_now = 10263;
y = d133*(1-(a.*stress_now.*x.^n)).*exp(-(b.*stress_now).*(x.^n));
hold on
plot(x, y,'b','linewidth', 2);
ax = gca;
ax.YLim = [5,20];
ax.XLim = [0,5];
grid on 
grid minor

subplot(2,2,2);
hold on
stress_now = 13427;
y = d174*(1-(a.*stress_now.*x.^n)).*exp(-(b.*stress_now).*(x.^n));
plot(x, y,'b','linewidth', 2);
ax = gca;
ax.YLim = [0,10];
ax.XLim = [0,5];
grid on 
grid minor

subplot(2,2,3);
hold on
stress_now = 16591;
y = d215*(1-(a.*stress_now.*x.^n)).*exp(-(b.*stress_now).*(x.^n));
plot(x, y,'b','linewidth', 2);
ax = gca;
ax.YLim = [0,10];
ax.XLim = [0,5];
grid on 
grid minor

subplot(2,2,4);
hold on
stress_now = 19677;
y = d255*(1-(a.*stress_now.*x.^n)).*exp(-(b.*stress_now).*(x.^n));
plot(x, y,'b','linewidth', 2);
ax = gca;
ax.YLim = [0,10];
ax.XLim = [0,5];

grid on 
grid minor