%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Week 4 2017/10/5
% Purpose: Error analysis simulation
%          and comparison between mathmatical computation
%          
%   Copyright (c) 2017 by Shanshan Xie
%   for Pressure Ulcer Prevention project
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Set Test Condition

C = 0.637e-6;
Rref = 10000;
Rfsr = 1e3:1:100e3;
delta_t = 92e-6;

Ideal_time_ratio = Rfsr./Rref;
t1 = 0.5*C*Rfsr;
t2 = 0.5*C*Rref*ones(1,length(t1));

%random number generation
rand_delta_t1 = delta_t*rand(1,length(t1));
rand_delta_t2 = delta_t*rand(1,length(t1));

t2_wError = t2 - rand_delta_t2;
t1_wError = t1 + rand_delta_t1;
timeRatio_wError = t1_wError./t2_wError;

% +/- Error - simulation
Error_sim1 = ((timeRatio_wError./Ideal_time_ratio)-1)*100;
Error_sim2 = (1-(timeRatio_wError./Ideal_time_ratio))*100;

%Computation Result
error_small = (delta_t./(0.5*C))*(1./Rfsr+1/Rref)*100;
error = error_small./(1-delta_t./t1);

figure 
semilogx(Rfsr, error, 'LineWidth',2);
hold on
semilogx(Rfsr, -error, 'LineWidth',2);

%Simulation Result
% hold on
scatter(Ideal_time_ratio*Rref, Error_sim1, 'b');
hold on
scatter(Ideal_time_ratio*Rref,Error_sim2, 'r');

grid on
grid minor

xticks([1000 10000 100000])
xticklabels({'1k', '10k', '100k'})
xlabel('Force Sensitive Resistor R_{FSR} (\Omega)','FontSize', 20)
% title('Force Sensitive Resistor vs Error','FontSize', 20)
ylabel('Error (%)','FontSize', 20)
lgd = legend('cal+','cal-','sim+','sim-');
lgd.FontSize = 16;



