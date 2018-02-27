
clear


load('p1_p2_10min_60samples_2018_2_26.mat')
% Part 2 1N force
F1 = 1;
Rfsr_1N = p2_1N_R;
% Part 2 2N force
F2 = 2;
Rfsr_2N = p2_2N_R;
% Part 2 3N force
F3 = 3;
Rfsr_3N = p2_3N_R; 
% Choose last time point to use for x calculation
t = length(Rfsr_2N);
% Choose the last point from data to use for x fit
Ro = Rfsr_2N(t);
fo = F2;

x=log(Rfsr_3N(t)/Ro)/(log(F3/fo));

% Use x to correct force
% Eventually will use polyfit parameters with a, b from Dev's work
F1_corr = fo*(Rfsr_1N/Ro).^(1/x);
F2_corr = fo*(Rfsr_2N/Ro).^(1/x);
F3_corr = fo*(Rfsr_3N/Ro).^(1/x);

% Array to use for deconvolution
zero = zeros(1,60);
F1_appl = [zero F1*ones(1,60)];
F2_appl = [zero F2*ones(1,60)];
F3_appl = [zero F3*ones(1,60)];
F1_meas = [zero F1_corr];
F2_meas = [zero F2_corr];
F3_meas = [zero F3_corr];

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

% Extract force array for inverse calculation
F1_ideal = F1_appl(length(F1_corr)+1 : length(F1_appl));
F2_ideal = F2_appl(length(F2_corr)+1 : length(F2_appl));
F3_ideal = F3_appl(length(F3_corr)+1 : length(F3_appl));

% Combine F1 array, F2 array and F3 array
F1F2F3_array = [F1_array ; F2_array ; F3_array];
F1F2F3_ideal = [F1_ideal F2_ideal F3_ideal];
F1F2F3_ideal = F1F2F3_ideal';

% Calculate magic vector h
h = pinv(F1F2F3_array)*F1F2F3_ideal;

% Get predicted force by multiplying h back
predi_array = F1F2F3_array*h;

% 1N force
F1_predi = F1F2F3_array*h;
F1_predi = F1_predi(1:length(F1_corr));
F1_predi = [zeros(length(F1_corr), 1); F1_predi];

% 2N force
F2_predi = F1F2F3_array*h;
F2_predi = F2_predi((length(F1_corr)+1) : (length(F1_corr)+length(F2_corr)));
F2_predi = [zeros(length(F2_corr), 1); F2_predi];

% 3N force
F3_predi = F1F2F3_array*h;
F3_predi = F3_predi((length(F1_corr)+length(F2_corr)+1) : end);
F3_predi = [zeros(length(F3_corr), 1) ; F3_predi];

% plot data
figure(1)

% Rfsr raw plot
subplot(4,1,1)
hold off
plot(Rfsr_1N)
hold on
plot(Rfsr_2N,'r')
plot(Rfsr_3N,'b')
ylabel('R_{FSR} [k \Omega]')
xlabel('TIME INDEX')

% Corrected force plot
subplot(4,1,2)
hold off
plot(F1_corr)
hold on
plot(F2_corr,'r')
plot(F3_corr,'r')
ylabel('F_{CORR} [N]')
xlabel('TIME INDEX')

subplot(2,1,2)
hold off
plot(F1_appl,':b')
hold on
plot(F2_appl,':r')
plot(F3_appl,':r')

plot(F1_meas)
plot(F2_meas)
plot(F3_meas)

plot(F1_predi,'b')
plot(F2_predi,'b')
plot(F3_predi,'b')
ylabel('F_{APPL} F_{MEAS} [N]')
xlabel('TIME INDEX')
axis([0 120 -1 4])
grid on


