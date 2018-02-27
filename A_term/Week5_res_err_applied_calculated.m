


Rfsr_applied = [
    9780
    14900
    19774
    29500
    50500
    99500];

Rfsr_cal = [
    9660
    14539
    19290
    28784
    49235
    96761];

err = [
    1.227678937
    2.420172925
    2.445139476
    2.425762712
    2.504531975
    2.752361809];

% Rfsr1 = [9870
% 99700
% 1964
% 29710
% 989.12];
% error1 = [2.241070497
% 1.50380877
% 20.31236511
% 1.588109482
% 36.63138864];


%calculation
%Set Test Condition
delta_t = 32e-6;
C = 640e-9;
Rref = 10000;
Rfsr = 1e3:100:100e3;
%Computation Result
error = (delta_t./C)*(1./Rfsr+1/Rref)*100;


subplot(2,1,1);
plot(Rfsr_applied./1000, Rfsr_cal./1000, '-o',...
    'LineWidth',2,...
    'MarkerSize',10);
grid on
grid minor
axis([10 100 10 100]);
xlabel('APPLIED RESISTOR VALUE (k\Omega)','FontSize', 14);
% title('Force Sensitive Resistor vs Error','FontSize', 20)
ylabel('MEASURED RESISTOR VALUE (k\Omega)','FontSize', 14);

subplot(2,1,2);
plot(Rfsr_applied./1000, err, '-o',...
    'LineWidth',2,...
    'MarkerSize',10);
hold on
plot(Rfsr./1000, error, 'LineWidth',2);

axis([10 100 -3 3]);
xlabel('APPLIED RESISTOR VALUE (k\Omega)','FontSize', 14);
% title('Force Sensitive Resistor vs Error','FontSize', 20)
ylabel('ERROR (%)','FontSize', 14);

lgd = legend('Experiment','Simulation');
lgd.FontSize = 16;
grid on
grid minor




