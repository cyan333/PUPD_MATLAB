
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
F2_appl = [zero F2*ones(1,59)];
F3_appl = [zero 1.5 F3*ones(1,59)];
F4_appl = [zero F4*ones(1,60)];
F5_appl = [zero F5*ones(1,60)];

F1_meas = [zero F1_corr];
F2_meas = [zero F2_corr];
F3_meas = [zero F3_corr];
F4_meas = [zero F4_corr];
F5_meas = [zero F5_corr];

%%%%%%%%%%%%%%%%%%% Standard Deviation %%%%%%%%%%%%%%%%%%%%

% Calculate Standard Deviation from Force 1 prediction result

% Create a 3 dimention matrix, where each row corresponding to each force
% and each page corresponding to each different sampel line

for lineIndex = 1:40
    for forceIndex = 1:5
       array = [];
       elementIndex = 1;
       base = forceIndex/(1+lineIndex);
       element = base * elementIndex;
       while element<forceIndex 
           array = [array element];
           elementIndex = elementIndex+1;
           element = base * elementIndex;
       end
       F_appl(forceIndex,:,lineIndex) = [zero array F12345_appl(forceIndex)*ones(1,(60-lineIndex))];
    end
    
    [h(lineIndex,:),...
       F_predi(1,:,lineIndex),...
       F_predi(2,:,lineIndex),...
       F_predi(3,:,lineIndex),...
       F_predi(4,:,lineIndex),...
       F_predi(5,:,lineIndex)]=...
       Deconvolution_Algorithm_Function(...
       F1_corr,F2_corr,F3_corr,F4_corr,F5_corr,...
       F1_meas,F2_meas,F3_meas,F4_meas,F5_meas,...
       F_appl(1,:,lineIndex),...
       F_appl(2,:,lineIndex),...
       F_appl(3,:,lineIndex),...
       F_appl(4,:,lineIndex),...
       F_appl(5,:,lineIndex));
       
    for j=1:5
        F_std(j,lineIndex) = std(F_predi(j,(61+lineIndex):120,lineIndex));
%         figure(j)
%         plot(F_predi(j,61:120,lineIndex),'DisplayName',num2str(lineIndex));
%         hold on
    end
    
%     figure(100)
%     plot(h(lineIndex,:),'DisplayName',num2str(lineIndex));
%     hold on
  
end

% Plot Standard Deviation for every force
for i=1:5
    figure(61)
    subplot(5,1,i)
    plot(F_std(i,:),'DisplayName',num2str(i));
    legend 
    hold on
end

% Second Order System Critically Damped Step Response
zeta = 1:0.5:5.5;

for lineIndex=1:10
    for amptitute=1:5
        num = amptitute;
        den = [1 2*zeta(lineIndex) 1];
        a = tf(num,den);
        [temp_step,temp_time]=step(a,60);
    %         figure(1)
    %         step(a,60);
    %         hold on
        take_this_index = 1;
        temp_time=floor(temp_time);
        for temp_index=1:length(temp_time)
            if(temp_time(temp_index) == take_this_index)
                temp_step_array(:,take_this_index)=temp_step(temp_index);
                take_this_index = take_this_index+1;
            end
        end
        
%%%%%%%%%%%%%%%%%%% Plot Step Response for Second Order System %%%%%%%%%%%%%%%%%%%%
        figure(25)
        plot(temp_step_array);
        hold on


        F_appl_damp(amptitute,:,lineIndex) = [zeros(1,60) temp_step_array];

    end
    
    % Loop through all the lines and process the algorithm
    [h_damp(lineIndex,:),...
           F_predi_damp(1,:,lineIndex),...
           F_predi_damp(2,:,lineIndex),...
           F_predi_damp(3,:,lineIndex),...
           F_predi_damp(4,:,lineIndex),...
           F_predi_damp(5,:,lineIndex)]=...
           Deconvolution_Algorithm_Function(...
           F1_corr,F2_corr,F3_corr,F4_corr,F5_corr,...
           F1_meas,F2_meas,F3_meas,F4_meas,F5_meas,...
           F_appl_damp(1,:,lineIndex),...
           F_appl_damp(2,:,lineIndex),...
           F_appl_damp(3,:,lineIndex),...
           F_appl_damp(4,:,lineIndex),...
           F_appl_damp(5,:,lineIndex));
       
    % Calculate the standard deviation for each line (last 60 data)
    for j=1:5
    F_std_damp(j,lineIndex) = std(F_predi_damp(j,(61+lineIndex):120,lineIndex));
    
%%%%%%%%%%%%%%%%%%% Plot Predicted Data for 2nd Order Step Applied Force %%%%%%%%%%%%%%%%%%%%
    figure(90)
    subplot(5,1,j)
    plot(F_predi_damp(j,61:120,lineIndex),'DisplayName',num2str(lineIndex));
    hold on

    end
end
    
% Plot Standard Deviation for every force
for i=1:5
    figure(51)
    subplot(5,1,i)
    plot(F_std(i,:),'DisplayName',num2str(i));
    legend 
    hold on
end




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
