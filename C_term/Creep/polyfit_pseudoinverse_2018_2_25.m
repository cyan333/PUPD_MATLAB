clear
% load('linear_signal_pros_60sample_2018_2_23.mat')
% f1 = 117; %mmgH
% R1 = 25285; %ohm
% f2 = 173; %mmgh
% R2 = 13255; %ohm
% 
% x = (log10(R1)-log10(R2))/(log10(f1)-log10(f2));


% testr1

% Uses fake data to try algorithms

% 1N force
F1=1;
R1_t=[40  35  31  28  26 25.5 25 24.7 24.3 24.1 24 ];

% 2N force
F2=2;
R2_t=[24  21  18  17  16 15  14.5  14 13.7  13.5 13.3];



% choose time point to use for x fit
t_fit=8;
% choose Ro and Fo from data
Ro=R1_t(t_fit);
Fo=F1;

x=log(R2_t(t_fit)/Ro)/(log(F2/Fo));

% Use x to correct force
% Eventually will use polyfit parameters with a, b from Dev's work
F1_corr=Fo*(R1_t./Ro).^(1/x);
F2_corr=Fo*(R2_t./Ro).^(1/x);

% Make up signals to use in deconvolution
F1_appl=[0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 ];
F2_appl=[0 0 0 0 0 0 0 0 0 0 0 2 2 2 2 2 2 2 2 2 2 2 ];
F1_meas=[0 0 0 0 0 0 0 0 0 0 0 F1_corr];
F2_meas=[0 0 0 0 0 0 0 0 0 0 0 F2_corr];

% Create Array for Pseudoinverse


for i = 1:length(F1_corr)
    F1_array(i,:) = F1_meas( i+1 : 11+i );
    F2_array(i,:) = F2_meas( i+1 : 11+i );
end
% h_vector = zeros( length(F1_corr) , 1);

F1_ideal = ones(length(F1_corr) , 1)

h = inv(F1_array)*F1_ideal

% plot data
figure(11)
subplot(4,1,1)
hold off
plot(R1_t)
hold on
plot(R2_t,'r')
ylabel('R_{FSR} [k \Omega]')
xlabel('TIME INDEX')

subplot(4,1,2)
hold off
plot(F1_corr)
hold on
plot(F2_corr,'r')
ylabel('F_{CORR} [N]')
xlabel('TIME INDEX')

subplot(2,1,2)
hold off
plot(F1_appl)
hold on
plot(F2_appl,'r')
plot(F1_meas)
plot(F2_meas,'r')
ylabel('F_{APPL} F_{MEAS} [N]')
xlabel('TIME INDEX')






