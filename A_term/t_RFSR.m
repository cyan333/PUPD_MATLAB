clear

R1 = 1e3;
R2 = 5e3;
R1_Max = R1*(1+0.05);
R1_Min = R1*(1-0.05);
R2_Max = R2*(1+0.05);
R2_Min = R2*(1-0.05);

RFSR = [5000:10:50e3];

t = (RFSR*R1+R1*R2)./(RFSR*R2+R1*R2);

t_R1_R2_Max = (RFSR*R1_Max+R1_Max*R2_Max)./(RFSR*R2_Max+R1_Max*R2_Max);
t_R1_R2_Min = (RFSR*R1_Min+R1_Min*R2_Min)./(RFSR*R2_Min+R1_Min*R2_Min);

t_R2_Max = (RFSR*R1+R1*R2_Max)./(RFSR*R2_Max+R1*R2_Max);
t_R2_Min = (RFSR*R1+R1*R2_Min)./(RFSR*R2_Min+R1*R2_Min);

%find points
index = find( RFSR == 10e3);
t_point = t(index); 
t_max_point = t_R2_Max(index); 
t_min_point = t_R2_Min(index); 

%plot
figure
semilogx(RFSR, t, '-b',...
    'LineWidth',2,...
    'MarkerFaceColor','red',...
    'MarkerSize',20)

% hold on
% semilogx(RFSR, t_R2_Max, '--r',...
%     'LineWidth',2,...
%     'MarkerSize',10)
% 
% hold on
% semilogx(RFSR, t_R2_Min, ':k',...
%     'LineWidth',2,...
%     'MarkerSize',10)

hold on
semilogx(RFSR, t_R1_R2_Max, '-k',...
    'LineWidth',2,...
    'MarkerSize',10)

hold on
semilogx(RFSR, t_R1_R2_Min, '-r',...
    'LineWidth',2,...
    'MarkerSize',10)

axis([5e3 50e3 0.2 0.35])
set(gca,'fontsize',12)
xticks([5000 10e3 50e3])
xticklabels({'5K','10K','50K'});

ylabel('Time Ratio t_{r1}/t_{r2}', 'FontSize', 16);
xlabel('R_{FSR} (\Omega)', 'FontSize', 16);
grid on
grid minor



