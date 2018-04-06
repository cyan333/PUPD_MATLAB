
clear

% 60 Sample Data 10min
load('p4_p2_10min_2018_4_3_softbase.mat')
% Part 2 1N force
F1 = 1;
Rfsr_1N = p4_1N_R;
% Part 2 2N force
F2 = 2;
Rfsr_2N = p4_2N_R;
% Part 3 3N force
F3 = 3;
Rfsr_3N = p4_3N_R;
% Part 4 4N force
F4 = 4;
Rfsr_4N = p4_4N_R;
% Part 2 2N force
F5 = 5;
Rfsr_5N = p4_5N_R;

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
F1_appl = [zero F1*ones(1,60)];
F2_appl = [zero 1 F2*ones(1,59)];
F3_appl = [zero 1.5 F3*ones(1,59)];
F4_appl = [zero F4*ones(1,60)];
F5_appl = [zero F5*ones(1,60)];

F1_meas = [zero F1_corr];
F2_meas = [zero F2_corr];
F3_meas = [zero F3_corr];
F4_meas = [zero F4_corr];
F5_meas = [zero F5_corr];

[F1_predi,F2_predi,F3_predi,F4_predi,F5_predi] = ...
    Deconvolution_Algorithm_Function(...
    F1_corr,F2_corr,F3_corr,F4_corr,F5_corr,...
    F1_meas,F2_meas,F3_meas,F4_meas,F5_meas,...
    F1_appl,F2_appl,F3_appl,F4_appl,F5_appl);

%%%%%%%%%%%%%%%%%%% Standard Deviation %%%%%%%%%%%%%%%%%%%%

% Calculate Standard Deviation from Force 1 prediction result

% Create a matrix like
% [0 0 0 0 0 0.5  1    1    1 1]
% [0 0 0 0 0 0.25 0.75 1    1 1]
% [0 0 0 0 0 0.25 0.5  0.75 1 1]

for lineIndex = 1:2
   array = [];
   elementIndex = 1;
   base = 5/(1+lineIndex);
   element = base * elementIndex;
   while element<5 
       array = [array element];
       elementIndex = elementIndex+1;
       element = base * elementIndex;
   end
   F5_appl = [zero array F5*ones(1,(60-lineIndex))];
   figure(1)
   plot(F5_appl)
   hold on
   [h,F1_predi,F2_predi,F3_predi,F4_predi,F5_predi] = ...
       Deconvolution_Algorithm_Function(...
       F1_corr,F2_corr,F3_corr,F4_corr,F5_corr,...
       F1_meas,F2_meas,F3_meas,F4_meas,F5_meas,...
       F1_appl,F2_appl,F3_appl,F4_appl,F5_appl);
   figure(2)
    plot(F5_predi)
   hold on
   figure(3)
    plot(h)
   hold on
    F5_std(lineIndex) = std(F5_predi(61:120));
end

figure(4)
plot(F5_std);



% F1_appl = [zero 0.25 0.5 0.75 F1*ones(1,57)];
% plot(F1_appl,'DisplayName','4')
% [F1_predi,F2_predi,F3_predi,F4_predi,F5_predi] = ...
%     Deconvolution_Algorithm_Function(...
%     F1_corr,F2_corr,F3_corr,F4_corr,F5_corr,...
%     F1_meas,F2_meas,F3_meas,F4_meas,F5_meas,...
%     F1_appl,F2_appl,F3_appl,F4_appl,F5_appl);
% F1_std_4 = std(F1_predi(61:120));
% 
% F1_appl = [zero 0.17 0.34 0.51 0.68 0.85 F1*ones(1,55)];
% plot(F1_appl,'DisplayName','8')
% [F1_predi,F2_predi,F3_predi,F4_predi,F5_predi] = ...
%     Deconvolution_Algorithm_Function(...
%     F1_corr,F2_corr,F3_corr,F4_corr,F5_corr,...
%     F1_meas,F2_meas,F3_meas,F4_meas,F5_meas,...
%     F1_appl,F2_appl,F3_appl,F4_appl,F5_appl);
% F1_std_6 = std(F1_predi(61:120));
% 
% F1_appl = [zero 0.125 0.25 0.375 0.5 0.625 0.75 0.875 F1*ones(1,53)];
% plot(F1_appl,'DisplayName','8')
% [F1_predi,F2_predi,F3_predi,F4_predi,F5_predi] = ...
%     Deconvolution_Algorithm_Function(...
%     F1_corr,F2_corr,F3_corr,F4_corr,F5_corr,...
%     F1_meas,F2_meas,F3_meas,F4_meas,F5_meas,...
%     F1_appl,F2_appl,F3_appl,F4_appl,F5_appl);
% F1_std_8 = std(F1_predi(61:120));
% 
% F1_appl = [zero 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 F1*ones(1,51)];
% plot(F1_appl,'DisplayName','8')
% [F1_predi,F2_predi,F3_predi,F4_predi,F5_predi] = ...
%     Deconvolution_Algorithm_Function(...
%     F1_corr,F2_corr,F3_corr,F4_corr,F5_corr,...
%     F1_meas,F2_meas,F3_meas,F4_meas,F5_meas,...
%     F1_appl,F2_appl,F3_appl,F4_appl,F5_appl);
% F1_std_10 = std(F1_predi(61:120));
% 
% F1_appl = [zero 0.83 0.166 0.3 0.4 0.5 0.6 0.7 0.8 0.9 F1*ones(1,51)];
% plot(F1_appl,'DisplayName','8')
% [F1_predi,F2_predi,F3_predi,F4_predi,F5_predi] = ...
%     Deconvolution_Algorithm_Function(...
%     F1_corr,F2_corr,F3_corr,F4_corr,F5_corr,...
%     F1_meas,F2_meas,F3_meas,F4_meas,F5_meas,...
%     F1_appl,F2_appl,F3_appl,F4_appl,F5_appl);
% F1_std_10 = std(F1_predi(61:120));
% 
% F1_appl = [zero 0.0625 0.125 0.1875 0.25 0.3125 0.375 0.4375 0.5 0.5625 0.625 0.6875 0.75 0.8125 0.875 0.9375 F1*ones(1,45)];
% plot(F1_appl,'DisplayName','16')
% [F1_predi,F2_predi,F3_predi,F4_predi,F5_predi] = ...
%     Deconvolution_Algorithm_Function(...
%     F1_corr,F2_corr,F3_corr,F4_corr,F5_corr,...
%     F1_meas,F2_meas,F3_meas,F4_meas,F5_meas,...
%     F1_appl,F2_appl,F3_appl,F4_appl,F5_appl);
% F1_std_16 = std(F1_predi(61:120));


%%%%%%%%%%%%%%%%%%% Plot Data %%%%%%%%%%%%%%%%%%%%
% figure(1)
% % Rfsr raw plot
% subplot(4,1,1)
% hold off
% plot(Rfsr_1N,'DisplayName','1N')
% hold on
% plot(Rfsr_2N,'DisplayName','2N')
% plot(Rfsr_3N,'DisplayName','3N')
% plot(Rfsr_4N,'DisplayName','4N')
% plot(Rfsr_5N,'DisplayName','5N')
% ylabel('R_{FSR} [k\Omega]')
% xlabel('TIME SAMPLE [10s/Sample]')
% grid on
% legend('show')
% 
% % Corrected force plot
% % figure(10)
% subplot(4,1,2)
% hold off
% plot(F1_corr,'DisplayName','1N')
% hold on
% plot(F2_corr,'DisplayName','2N')
% plot(F3_corr,'DisplayName','3N')
% plot(F4_corr,'DisplayName','4N')
% plot(F5_corr,'DisplayName','5N')
% ylabel('F_{CORR} [N]')
% xlabel('TIME SAMPLE [10s/Sample]')
% grid on
% legend('show')
% 
% % figure(11)
% subplot(2,1,2)
% hold off
% plot(F1_appl,'--b','DisplayName','1N - Applied')
% hold on
% plot(F2_appl,'--r','DisplayName','2N - Applied')
% plot(F3_appl,'--r','DisplayName','3N - Applied')
% plot(F4_appl,'--r','DisplayName','4N - Applied')
% plot(F5_appl,'--r','DisplayName','5N - Applied')
% 
% plot(F1_meas,'DisplayName','1N - Measured')
% plot(F2_meas,'DisplayName','2N - Measured')
% plot(F3_meas,'DisplayName','3N - Measured')
% plot(F4_meas,'DisplayName','4N - Measured')
% plot(F5_meas,'DisplayName','5N - Measured')
% 
% plot(F1_predi,'b','DisplayName','1N - Predicted')
% plot(F2_predi,'b','DisplayName','2N - Predicted')
% plot(F3_predi,'b','DisplayName','3N - Predicted')
% plot(F4_predi,'b','DisplayName','4N - Predicted')
% plot(F5_predi,'b','DisplayName','5N - Predicted')
% ylabel('F_{APPL} F_{MEAS} [N]')
% xlabel('TIME SAMPLE [10s/Sample]')
% axis([0 120 -1 6])
% grid on
% grid minor
% legend('show')

% figure(2)
% hold off
% scatter(F12345_appl,F12345_corr,'b','DisplayName','Experimental Data')
% hold on
% plot(polyval(polyfit_result,F12345_corr),F12345_corr,'b','DisplayName','Polyfit Result')
% % plot(F12345_appl,F_poly,'r','DisplayName','Polyfit')
% scatter(F12345_appl,F12345_poly,'r','DisplayName','after Polyfit')
% axis([0 6 0 6])
% ylabel('F_{MEAS} [N]')
% xlabel('F_{APPL} [N]')
% grid on
% legend('show')
% grid minor
% 
% figure(3)
% hold off
% plot(F1_predi,'b','DisplayName','1N - Predicted')
% hold on
% plot(F2_predi,'b','DisplayName','2N - Predicted')
% plot(F3_predi,'b','DisplayName','3N - Predicted')
% plot(F4_predi,'b','DisplayName','4N - Predicted')
% plot(F5_predi,'b','DisplayName','5N - Predicted')
% ylabel('F_{APPL} F_{MEAS} [N]')
% xlabel('TIME SAMPLE [10s/Sample]')
% axis([0 120 -1 6])
% grid on
% grid minor
% legend('show')
