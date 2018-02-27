
clear

Rfsr = 10e3;
Rref = 1000;
C = 1e-12;
V_BATT = 3;
V_LTH = 1.94;
Error = 0.001;
delta_t_sim = 1e-10;
% t = [0:0.00000001:1e-7];
% Vc = VBATT-VBATT*(2.^(-t./(Rfsr*C)));
% Error = ((Rfsr./Rref)-1)./((t_real./delta_t)+1);

t_fsr_real = -log(1-(V_LTH./V_BATT))*Rfsr*C;
t_ref_real = -log(1-(V_LTH./V_BATT))*Rref*C;

t_ratio_real = t_ref_real/t_fsr_real;

t_fsr_withError = t_fsr_real + delta_t_sim;
t_ref_withError = t_ref_real + delta_t_sim;

t_ratio_withError = t_ref_withError/t_fsr_withError;

Rfsr_withError = Rref./t_ratio_withError;

Rfsr_Error = 100*((Rfsr_withError./Rfsr)-1);

Time_ratio_error = ((t_ratio_withError./t_ratio_real)-1)*100;

% target = t_ratio_real*(1+Error);

% delta_t_cal = (t_fsr_real*Error)./((Rfsr./Rref)-1-Error);

% axis([1e3 5e3 1e-8 1e-12])
% set(gca,'fontsize',12)
% xticks([5000 10e3 50e3])
% xticklabels({'5K','10K','50K'});

% figure
% loglog(Rfsr, delta_t, '-b',...
%     'DisplayName','Perfect Resistor',...
%     'LineWidth',2,...
%     'MarkerFaceColor','red',...
%     'MarkerSize',20)
% grid on

