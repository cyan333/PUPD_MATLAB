clear

R1 = 1e3;
R2 = 100e3;
R1_Max = R1*(1+0.05);
R1_Min = R1*(1-0.05);
R2_Max = R2*(1+0.05);
R2_Min = R2*(1-0.05);

t = [0.01:0.001:0.50];

%Standard
RFSR = R1*R2*(1-t)./(t*R2-R1);
RFSR_R1min_R2min = R1_Min*R2_Min*(1-t)./(t*R2_Min-R1_Min);
RFSR_R1min_R2max = R1_Min*R2_Max*(1-t)./(t*R2_Max-R1_Min);
RFSR_R1max_R2max = R1_Max*R2_Max*(1-t)./(t*R2_Max-R1_Max);
RFSR_R1max_R2min = R1_Max*R2_Min*(1-t)./(t*R2_Min-R1_Max);

%plot
figure
semilogy(t, RFSR, '-b',...
    'DisplayName','Perfect Resistor',...
    'LineWidth',2,...
    'MarkerFaceColor','red',...
    'MarkerSize',20)

hold on

semilogy(t, RFSR_R1min_R2min, '--r',...
    'DisplayName','R1:min; R2:min',...
    'LineWidth',2,...
    'MarkerFaceColor','red',...
    'MarkerSize',20)

hold on

semilogy(t, RFSR_R1min_R2max, '--k',...
    'DisplayName','R1:min; R2:max',...
    'LineWidth',2,...
    'MarkerFaceColor','red',...
    'MarkerSize',20)

hold on
semilogy(t, RFSR_R1max_R2max, '-r',...
    'DisplayName','R1:max; R2:max',...
    'LineWidth',2,...
    'MarkerFaceColor','red',...
    'MarkerSize',20)

hold on
semilogy(t, RFSR_R1max_R2min, '-k',...
    'DisplayName','R1:max; R2:min',...
    'LineWidth',2,...
    'MarkerFaceColor','red',...
    'MarkerSize',20)

lgd = legend('show');
lgd.FontSize = 14;

axis([0.01 0.2 5e3 100e3])
set(gca,'fontsize',12)
yticks([5000 9000 10e3 13e3 20e3 50e3 100e3])
yticklabels({'5K','9K','10K','13K','20K','50K','100K'});


title('R_{FSR} vs Time Ratio t_{r1}/t_{r2} @ R2 = 100K\Omega','FontSize', 16)
xlabel('Time Ratio t_{r1}/t_{r2}', 'FontSize', 16);
ylabel('R_{FSR} (\Omega)', 'FontSize', 16);
grid on
grid minor



