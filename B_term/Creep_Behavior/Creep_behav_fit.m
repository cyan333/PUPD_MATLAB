
clc;clear;close all;

load('Reset_t0_r_r_r0');
% load('Reset_t0_r_r0');
% figure(1)
% % subplot(2,2,1);
% plot(t133g_RR0, r133g_RR0, '-ob', ...
%     'MarkerSize',5);
% hold on
% [fitresult_133, gof_133] = createFit(t133g_RR0, r133g_RR0);
% ax = gca;
% ax.YLim = [0.06,0.2];
% ax.XLim = [0,3];
% % legend('Experiement','Creep Model');
% title('Weight = 133g');
% 
% 
% hold on
% plot(t174g_RR0,r174g_RR0, '-ok', ...
%     'MarkerSize',5);
% % title('Weight = 174g');
% hold on
% [fitresult_174, gof_174] = createFit(t174g_RR0, r174g_RR0);
% ax = gca;
% ax.YLim = [0.06,0.2];
% ax.XLim = [0,3];
% % legend('Experiement','Creep Model');
% 
% hold on
% plot(t215g_RR0,r215g_RR0, '-om', ...
%     'MarkerSize',5);
% % title('Weight = 215g');
% hold on
% [fitresult_215, gof_215] = createFit(t215g_RR0, r215g_RR0);
% ax = gca;
% ax.YLim = [0.08,0.2];
% ax.XLim = [0,3];
% % legend('Experiement','Creep Model');
% 
% hold on
% plot(t255g_RR0,r255g_RR0, '-or', ...
%     'MarkerSize',5);
% % title('Weight = 255g');
% hold on
% [fitresult_255, gof_255] = createFit(t255g_RR0, r255g_RR0);
% ax = gca;
% ax.YLim = [0.06,0.2];
% ax.XLim = [0,3];
% 
% legend('133g_exp','133g_ideal','174g_exp','174g_ideal','215g_exp','215g_ideal','255g_exp','255g_ideal');
subplot(2,1,1);
plot(t133_R,r133_R,'r','Linewidth',4);
hold on
plot(t174_R,r174_R,'k','Linewidth',4);
hold on
plot(t215_R,r215_R,'m','Linewidth',4);
hold on
plot(t255_R,r255_R,'b','Linewidth',4);
ax = gca;
ax.YLim = [0,50];
ax.XLim = [0,0.01];

grid on
grid minor

legend('133g','174g','215g','255g');
xlabel('Time (min)');
ylabel('R (ohm)');

subplot(2,1,2);
plot(t133_R_R0,r133_R_R0,'r','Linewidth',4);
hold on
plot(t174_R_R0,r174_R_R0,'k','Linewidth',4);
hold on
plot(t215_R_R0,r215_R_R0,'m','Linewidth',4);
hold on
plot(t255_R_R0,r255_R_R0,'b','Linewidth',4);
ax = gca;
ax.YLim = [0,0.2];
ax.XLim = [0,0.01];

grid on
grid minor

legend('133g','174g','215g','255g');
xlabel('Time (min)');
ylabel('R/R0 (ohm)');





