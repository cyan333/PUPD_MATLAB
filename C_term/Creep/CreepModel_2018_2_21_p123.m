clear all
load('Part123_60s_2_21_2018.mat');


figure('Name','Part 1 2 3 Experiment Data');
scatter(t_108g_part1, R_108g_part1,'DisplayName','108g_1');
hold on
scatter(t_108g_part2, R_108g_part2,'DisplayName','108g_2');
hold on
scatter(t_202g_part1, R_202g_part1,'DisplayName','202g_1');
hold on
scatter(t_202g_part2, R_202g_part2,'DisplayName','202g_2');
hold on
scatter(t_301g_part1, R_301g_part1,'DisplayName','301g_1');
hold on
scatter(t_301g_part2, R_301g_part2,'DisplayName','301g_2');
hold on
scatter(t_408g_part1, R_408g_part1,'DisplayName','301g_1');
hold on
scatter(t_404g_part2, R_404g_part2,'DisplayName','301g_2');

grid on 
grid minor

a = 0.001;
b = 0.7;
n = 0.05;

R01_part1 = 121;
R01_part2 = 142;
R02_part1 = 50;
R02_part2 = 69;

R03_part1 = 49.2;
R03_part2 = 64.2;
R04_part1 = 47;
R04_part2 = 47;

x = 0:0.01:60;

% Part 1 & 2 108g

% figure('Name','108g Exp and Prediction');
figure('Name','Exp and Prediction');
subplot(2,2,1);
scatter(t_108g_part1, R_108g_part1,'DisplayName','108g_1');
hold on
scatter(t_108g_part2, R_108g_part2,'DisplayName','108g_2');


y1_part1 = (1-(a.*x.^n)).*exp(-b*(x.^n)).*R01_part1;
hold on
plot(x,y1_part1,'LineWidth', 2,'DisplayName','108g_1');


y1_part2 = (1-(a.*x.^n)).*exp(-b*(x.^n)).*R01_part2;
hold on
plot(x,y1_part2,'LineWidth', 2,'DisplayName','108g_2');

grid minor
ax = gca;
ax.YLim = [30,100];
ax.XLim = [0,60];


% Part 1 & 2 202g
subplot(2,2,2);
scatter(t_202g_part1, R_202g_part1,'DisplayName','202g_1');
hold on
scatter(t_202g_part2, R_202g_part2,'DisplayName','202g_2');


y2_part1 = (1-(a*1.8.*x.^(n))).*exp(-b.*1.8*(x.^(n))).*R02_part1;
hold on
plot(x,y2_part1,'LineWidth', 2);


y2_part2 = (1-(a*1.8.*x.^(n))).*exp(-b.*1.8*(x.^(n))).*R02_part2;
hold on
plot(x,y2_part2,'LineWidth', 2);

grid minor

ax = gca;
ax.YLim = [0,40];
ax.XLim = [0,60];

% Part 1 & 2 3N
subplot(2,2,3);
scatter(t_301g_part1, R_301g_part1,'DisplayName','3N_1');
hold on
scatter(t_301g_part2, R_301g_part2,'DisplayName','3N_2');


y3_part1 = (1-(a*2.7.*x.^(n))).*exp(-b.*2.7*(x.^(n))).*R03_part1;
hold on
plot(x,y3_part1,'LineWidth', 2);


y3_part2 = (1-(a*2.7.*x.^(n))).*exp(-b.*2.7*(x.^(n))).*R03_part2;
hold on
plot(x,y3_part2,'LineWidth', 2);

grid minor

ax = gca;
ax.YLim = [4,12];
ax.XLim = [0,60];


% Part 1 & 2 4N
subplot(2,2,4);
scatter(t_408g_part1, R_408g_part1,'DisplayName','4N_1');
hold on
scatter(t_404g_part2, R_404g_part2,'DisplayName','4N_2');


y4_part1 = (1-(a*3.7.*x.^(n))).*exp(-b.*3.7*(x.^(n))).*R04_part1;
hold on
plot(x,y4_part1,'LineWidth', 2);


y4_part2 = (1-(a*3.7.*x.^(n))).*exp(-b.*3.7*(x.^(n))).*R04_part2;
hold on
plot(x,y4_part2,'LineWidth', 2);

grid minor

ax = gca;
ax.YLim = [2,10];
ax.XLim = [0,60];



