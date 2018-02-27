load('CreepData_0214_2s_ChangeStartPoints.mat');
% 
figure('Name','Data and Prediction')
% subplot(2,2,1)
CreepFit_GeneralFxn_ABND(t_108g1, R_108g1)
hold on
% subplot(2,2,2)
CreepFit_GeneralFxn_ABND(t_202g1, R_202g1)
hold on
% subplot(2,2,3)
CreepFit_GeneralFxn_ABND(t_305g1, R_305g1)
hold on
% subplot(2,2,4)
CreepFit_GeneralFxn_ABND(t_408g1, R_408g1)

grid on
grid minor

ax = gca;
ax.YLim = [0,100];
ax.XLim = [0,1];

a = 6.01e-6;
b = 0.2467;
n = 0.23;

R01 = 65.98;
R02 = 22.55;
R03 = 15.82;
R04 = 10;

x = 0:0.01:3;
y = (1-(a.*x.^n)).*exp(-b*(x.^n)).*R01;

figure('Name','202g')

plot(x,y,'LineWidth', 2);
hold on
scatter(t_108g1, R_108g1,'DisplayName','108g_1');

y2 = (1-(a*2.*x.^n)).*exp(-b.*2*(x.^n)).*R02;

hold on
plot(x,y2,'LineWidth', 2);
hold on
scatter(t_202g1, R_202g1,'DisplayName','202g_1');

y3 = (1-(a*3.*x.^n)).*exp(-b.*3*(x.^n)).* R03;

hold on
plot(x,y3,'LineWidth', 2);
hold on
scatter(t_305g1, R_305g1,'DisplayName','305g_1');

y4 = (1-(a*4.*x.^n)).*exp(-b.*4*(x.^n)).*R04;
hold on
plot(x,y4,'LineWidth', 2);
hold on
scatter(t_408g1, R_408g1,'DisplayName','305g_1');
grid on
grid minor
ax = gca;
ax.YLim = [0,100];
ax.XLim = [0,1];


% plot(t_202g_1,R_202g_1,'DisplayName','202g_1');
% hold on;
% plot(t_202g_2,R_202g_2,'DisplayName','202g_2');
% hold on;
% 
% figure('Name','408g')
% plot(t_408g_1,R_408g_1,'DisplayName','408g_1');
% hold on;
% plot(t_408g_2,R_408g_2,'DisplayName','408g_2');
% hold on;
% plot(t_408g_3,R_408g_3,'DisplayName','408g_3');
% 
% figure('Name','505g')
% plot(t_505g_1,R_505g_1,'DisplayName','505g_1');
% hold on;
% plot(t_505g_2,R_505g_2,'DisplayName','505g_2');
% 
% figure('Name','All')
% semilogy(t_108g_1,R_108g_1,'DisplayName','108g_1');
% hold on;
% semilogy(t_202g_1,R_202g_1,'DisplayName','202g_1');
% hold on;
% semilogy(t_305g_1,R_305g_1,'DisplayName','305g_1');
% hold on;
% semilogy(t_408g_1,R_408g_1,'DisplayName','408g_1');
% hold on;
% semilogy(t_505g_2,R_505g_2,'DisplayName','505g_2');

% ax = gca;
% ax.YLim = [0,500];
% ax.XLim = [0,5];