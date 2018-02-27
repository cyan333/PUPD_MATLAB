
% Simulation 
t1 = 1e-6:1e-9:1e-3;
t2 = 10e-6*ones(1,length(t1));
Ideal_time_ratio = t1./t2;

rand_delta_t1 = 1.1e-7*rand(1,length(t1));
rand_delta_t2 = 1.1e-7*rand(1,length(t1));

t2_wError = t2 + rand_delta_t2;
t1_wError = t1 + rand_delta_t1;
timeRatio_wError = t1_wError./t2_wError;

% +/- Error
Error_sim1 = ((timeRatio_wError./Ideal_time_ratio)-1)*100;
Error_sim2 = (1-(timeRatio_wError./Ideal_time_ratio))*100;

%Wrong equation from week 2
Error_wrong1 = 100*((1 - Ideal_time_ratio)./((t1./rand_delta_t1)+Ideal_time_ratio));
Error_wrong2 = 100*((Ideal_time_ratio - 1)./((t1./rand_delta_t1)+Ideal_time_ratio));


% I think this equation is right. 
Error_cal1 = 100*((rand_delta_t1 - Ideal_time_ratio.*rand_delta_t2)./(t1 + Ideal_time_ratio.*rand_delta_t2));
Error_cal2 = 100*((Ideal_time_ratio.*rand_delta_t2 - rand_delta_t1)./(t1 + Ideal_time_ratio.*rand_delta_t2));
% 
semilogx(Ideal_time_ratio, Error_sim1, 'b');

hold on
semilogx(Ideal_time_ratio,Error_sim2, 'k');

% hold on
% semilogx (Ideal_time_ratio, Error_wrong1,'r');
% 
% hold on
% semilogx (Ideal_time_ratio,Error_wrong2,'p');

% hold on
% semilogx (Ideal_time_ratio,Error_cal1,'r');
% 
% hold on
% semilogx (Ideal_time_ratio,Error_cal2,'p');

set(gca,'fontsize',14)
% axis([0.1 1000 -5 3])
% yticks([-2 -1 0 1 2 3 4 5 6 7 8 9 10]);
% yticklabels({'-2', '-1', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10'});
% 
lgd = legend('Simulation1','Simulation2','Calculation1','Calculation2');
lgd.FontSize = 16;

grid on
xlabel('R_{FSR}/R_{REF}','FontSize', 16);
ylabel('Error (%)','FontSize', 16);
title ('Simulation Result','FontSize', 16);





