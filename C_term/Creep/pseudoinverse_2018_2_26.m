
clear

% 60 Sample Data 10min
load('p4_p2_10min_2018_4_3_softbase.mat')
% Part 2 1N force
F1 = 1;
Rfsr_1N = p2_1N_R;
% Part 2 2N force
F2 = 2;
Rfsr_2N = p2_2N_R;
% Part 3 3N force
F3 = 3;
Rfsr_3N = p2_3N_R;
% Part 4 4N force
F4 = 4;
Rfsr_4N = p2_4N_R;
% Part 2 2N force
F5 = 5;
Rfsr_5N = p2_5N_R;

% Choose last time point to use for x calculation
t = 60;
% Choose the last point from data to use for x fit
Ro = Rfsr_1N(t);
fo = F1;

x=log(Rfsr_5N(t)/Ro)/(log(F5/fo));

% Use x to correct force
% Eventually will use polyfit parameters with a, b from Dev's work
F1_corr = fo*(Rfsr_1N/Ro).^(1/x);
F2_corr = fo*(Rfsr_2N/Ro).^(1/x);
F3_corr = fo*(Rfsr_3N/Ro).^(1/x);
F4_corr = fo*(Rfsr_4N/Ro).^(1/x);
F5_corr = fo*(Rfsr_5N/Ro).^(1/x);



%%%%%%%%%%%%%%%%%%% PolyFit %%%%%%%%%%%%%%%%%%%%

% R = [Rfsr_1N(t) Rfsr_2N(t) Rfsr_3N(t) Rfsr_4N(t) Rfsr_5N(t)];
F12345_corr = [F1_corr(t) F2_corr(t) F3_corr(t) F4_corr(t) F5_corr(t)];
F12345_appl = [F1 F2 F3 F4 F5];
polyfit_result = polyfit(F12345_corr,F12345_appl,2);

%%%%%%%%%%%%%%%%%%% Recalculate after Polyfit %%%%%%%%%%%%%%%%%%%%
% Polyfit result
a = polyfit_result(1);
b = polyfit_result(2);
c = polyfit_result(3);

% Plot in Rfsr data for calibration
F1_corr = fo*(a*(Rfsr_1N/Ro).^(2/x)+b*(Rfsr_1N/Ro).^(1/x)+c);
F2_corr = fo*(a*(Rfsr_2N/Ro).^(2/x)+b*(Rfsr_2N/Ro).^(1/x)+c);
F3_corr = fo*(a*(Rfsr_3N/Ro).^(2/x)+b*(Rfsr_3N/Ro).^(1/x)+c);
F4_corr = fo*(a*(Rfsr_4N/Ro).^(2/x)+b*(Rfsr_4N/Ro).^(1/x)+c);
F5_corr = fo*(a*(Rfsr_5N/Ro).^(2/x)+b*(Rfsr_5N/Ro).^(1/x)+c);

% Get the last data point
F12345_poly = [F1_corr(t) F2_corr(t) F3_corr(t) F4_corr(t) F5_corr(t)];


% Array to use for deconvolution
% Manipulate the data in the middle to achieve max accuracy if neccessary
zero = zeros(1,60);
F1_appl = [zero 0.5 F1*ones(1,59)];
F2_appl = [zero 1 F2*ones(1,59)];
F3_appl = [zero 1.5 F3*ones(1,59)];
F4_appl = [zero F4*ones(1,60)];
F5_appl = [zero F5*ones(1,60)];

F1_meas = [zero F1_corr];
F2_meas = [zero F2_corr];
F3_meas = [zero F3_corr];
F4_meas = [zero F4_corr];
F5_meas = [zero F5_corr];

% Create Array for Pseudoinverse
for i = 1:length(F1_corr)
    F1_array(i,:) = F1_meas( i+1 : length(F1_corr)+i );
end

for i = 1:length(F2_corr)
    F2_array(i,:) = F2_meas( i+1 : length(F2_corr)+i );
end

for i = 1:length(F3_corr)
    F3_array(i,:) = F3_meas( i+1 : length(F3_corr)+i );
end

for i = 1:length(F3_corr)
    F4_array(i,:) = F4_meas( i+1 : length(F4_corr)+i );
end

for i = 1:length(F3_corr)
    F5_array(i,:) = F5_meas( i+1 : length(F5_corr)+i );
end

% Extract force array for inverse calculation
F1_ideal = F1_appl(length(F1_corr)+1 : length(F1_appl));
F2_ideal = F2_appl(length(F2_corr)+1 : length(F2_appl));
F3_ideal = F3_appl(length(F3_corr)+1 : length(F3_appl));
F4_ideal = F4_appl(length(F4_corr)+1 : length(F4_appl));
F5_ideal = F5_appl(length(F5_corr)+1 : length(F5_appl));

% Combine F1 array, F2 array and F3 array F4 array and F5 array
F1F2F3F4F5_array = [F1_array ; F2_array ; F3_array; F4_array; F5_array];
F1F2F3F4F5_ideal = [F1_ideal F2_ideal F3_ideal F4_ideal F5_ideal];
F1F2F3F4F5_ideal = F1F2F3F4F5_ideal';

% Calculate magic vector h
h = pinv(F1F2F3F4F5_array)*F1F2F3F4F5_ideal;

% Get predicted force by multiplying h back
predi_array = F1F2F3F4F5_array*h;

% 1N force
F1_predi = F1F2F3F4F5_array*h;
F1_predi_fonly = F1_predi(1:length(F1_corr));
F1_predi = [zeros(length(F1_corr), 1); F1_predi_fonly];

% 2N force
F2_predi = F1F2F3F4F5_array*h;
F2_predi = F2_predi((length(F1_corr)+1) : (length(F1_corr)+length(F2_corr)));
F2_predi = [zeros(length(F2_corr), 1); F2_predi];

% 3N force
F3_predi = F1F2F3F4F5_array*h;
F3_predi = F3_predi((length(F1_corr)+length(F2_corr)+1) : (length(F1_corr)+length(F2_corr)+length(F3_corr)));
F3_predi = [zeros(length(F3_corr), 1) ; F3_predi];

% 4N force
F4_predi = F1F2F3F4F5_array*h;
F4_predi = F4_predi((length(F1_corr)+length(F2_corr)+length(F3_corr)+1) : (length(F1_corr)+length(F2_corr)+length(F3_corr)+length(F4_corr)));
F4_predi = [zeros(length(F4_corr), 1) ; F4_predi];

% 5N force
F5_predi = F1F2F3F4F5_array*h;
F5_predi = F5_predi((length(F1_corr)+length(F2_corr)+length(F3_corr)+length(F3_corr)+1) : end);
F5_predi = [zeros(length(F4_corr), 1) ; F5_predi];


% %%%%%%%%%%%%%%%%%%% PolyFit %%%%%%%%%%%%%%%%%%%%
% 
% % R = [Rfsr_1N(t) Rfsr_2N(t) Rfsr_3N(t) Rfsr_4N(t) Rfsr_5N(t)];
% F12345_corr = [F1_corr(t) F2_corr(t) F3_corr(t) F4_corr(t) F5_corr(t)];
% F12345_appl = [F1 F2 F3 F4 F5];
% polyfit_result = polyfit(F12345_corr,F12345_appl,2);
% 
% %%%%%%%%%%%%%%%%%%% Recalculate after Polyfit %%%%%%%%%%%%%%%%%%%%
% % Polyfit result
% a = polyfit_result(1);
% b = polyfit_result(2);
% c = polyfit_result(3);
% 
% % Plot in Rfsr data for calibration
% F1_poly = fo*(a*(Rfsr_1N/Ro).^(2/x)+b*(Rfsr_1N/Ro).^(1/x)+c);
% F2_poly = fo*(a*(Rfsr_2N/Ro).^(2/x)+b*(Rfsr_2N/Ro).^(1/x)+c);
% F3_poly = fo*(a*(Rfsr_3N/Ro).^(2/x)+b*(Rfsr_3N/Ro).^(1/x)+c);
% F4_poly = fo*(a*(Rfsr_4N/Ro).^(2/x)+b*(Rfsr_4N/Ro).^(1/x)+c);
% F5_poly = fo*(a*(Rfsr_5N/Ro).^(2/x)+b*(Rfsr_5N/Ro).^(1/x)+c);
% 
% % Get the last data point
% F12345_poly = [F1_poly(t) F2_poly(t) F3_poly(t) F4_poly(t) F5_poly(t)];


%%%%%%%%%%%%%%%%%%% Plot Data %%%%%%%%%%%%%%%%%%%%
figure(1)

% Rfsr raw plot
subplot(4,1,1)
hold off
plot(Rfsr_1N,'DisplayName','1N')
hold on
plot(Rfsr_2N,'DisplayName','2N')
plot(Rfsr_3N,'DisplayName','3N')
plot(Rfsr_4N,'DisplayName','4N')
plot(Rfsr_5N,'DisplayName','5N')
ylabel('R_{FSR} [k\Omega]')
xlabel('TIME SAMPLE [10s/Sample]')
grid on
legend('show')

% Corrected force plot
% figure(10)
subplot(4,1,2)
hold off
plot(F1_corr,'DisplayName','1N')
hold on
plot(F2_corr,'DisplayName','2N')
plot(F3_corr,'DisplayName','3N')
plot(F4_corr,'DisplayName','4N')
plot(F5_corr,'DisplayName','5N')
ylabel('F_{CORR} [N]')
xlabel('TIME SAMPLE [10s/Sample]')
grid on
legend('show')

% figure(11)
subplot(2,1,2)
hold off
plot(F1_appl,'--b','DisplayName','1N - Applied')
hold on
plot(F2_appl,'--r','DisplayName','2N - Applied')
plot(F3_appl,'--r','DisplayName','3N - Applied')
plot(F4_appl,'--r','DisplayName','4N - Applied')
plot(F5_appl,'--r','DisplayName','5N - Applied')

plot(F1_meas,'DisplayName','1N - Measured')
plot(F2_meas,'DisplayName','2N - Measured')
plot(F3_meas,'DisplayName','3N - Measured')
plot(F4_meas,'DisplayName','4N - Measured')
plot(F5_meas,'DisplayName','5N - Measured')

plot(F1_predi,'b','DisplayName','1N - Predicted')
plot(F2_predi,'b','DisplayName','2N - Predicted')
plot(F3_predi,'b','DisplayName','3N - Predicted')
plot(F4_predi,'b','DisplayName','4N - Predicted')
plot(F5_predi,'b','DisplayName','5N - Predicted')
ylabel('F_{APPL} F_{MEAS} [N]')
xlabel('TIME SAMPLE [10s/Sample]')
axis([0 120 -1 6])
grid on
grid minor
legend('show')

figure(2)
hold off
scatter(F12345_appl,F12345_corr,'b','DisplayName','Experimental Data')
hold on
plot(polyval(polyfit_result,F12345_corr),F12345_corr,'b','DisplayName','Polyfit Result')
% plot(F12345_appl,F_poly,'r','DisplayName','Polyfit')
scatter(F12345_appl,F12345_poly,'r','DisplayName','after Polyfit')
axis([0 6 0 6])
ylabel('F_{MEAS} [N]')
xlabel('F_{APPL} [N]')
grid on
legend('show')
grid minor

figure(3)
hold off
plot(F1_predi,'b','DisplayName','1N - Predicted')
hold on
plot(F2_predi,'b','DisplayName','2N - Predicted')
plot(F3_predi,'b','DisplayName','3N - Predicted')
plot(F4_predi,'b','DisplayName','4N - Predicted')
plot(F5_predi,'b','DisplayName','5N - Predicted')
ylabel('F_{APPL} F_{MEAS} [N]')
xlabel('TIME SAMPLE [10s/Sample]')
axis([0 120 -1 6])
grid on
grid minor
legend('show')
