


Frequency = [
    10
    20
    50
    60
    80
    90
    100
    150
    200
    400
    500
    600
    700
    800
    900
    1000];

Trigger = [
    1.58
    1.58
    1.58
    1.58
    1.58
    1.58
    1.58
    1.62
    1.7
    1.82
    1.9
    1.94
    2.02
    2.1
    2.18
    2.22];

% subplot(2,1,1);
plot(Frequency, Trigger, '-o',...
    'LineWidth',2,...
    'MarkerSize',10);
grid on
grid minor
axis([0 1000 1.5 2.5]);
xlabel('Frequency (Hz)','FontSize', 16);
% title('Force Sensitive Resistor vs Error','FontSize', 20)
ylabel('Interrupt Trigger Voltage (V)','FontSize', 16);

Frequency1 = [ 100 150 200 400 500 600 700 800 900 1000];

Trigger1 = [1.58 1.62 1.7 1.82 1.9 1.94 2.02 2.1 2.18 2.22];

% subplot(2,1,2);
% plot(Frequency1, Trigger1, '-o',...
%     'LineWidth',2,...
%     'MarkerSize',10);
% axis([0 1000 1.5 2.5]);
% grid on
% grid minor
% xlabel('Frequency (Hz)','FontSize', 16);
% % title('Force Sensitive Resistor vs Error','FontSize', 20)
% ylabel('Interrupt Trigger Voltage (V)','FontSize', 16);


