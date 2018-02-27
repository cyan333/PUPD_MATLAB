

dataset = xlsread('week6_added_cap_experiment.xlsx', 'no_extra_cap', 'A2:AL50');

Rfsr = [dataset(1,1)
        dataset(1,4)
        dataset(1,7)
        dataset(1,10)
        dataset(1,13)
        dataset(1,16)
        dataset(1,19)
        dataset(1,23)
        dataset(1,27)
        dataset(1,31)
        dataset(1,35)];

deltaT = [
    max(dataset(:,3))-min(dataset(:,3))
    max(dataset(:,6))-min(dataset(:,6))
    max(dataset(:,9))-min(dataset(:,9))
    max(dataset(:,12))-min(dataset(:,12))
    max(dataset(:,15))-min(dataset(:,15))
    max(dataset(:,18))-min(dataset(:,18))
    max(dataset(:,22))-min(dataset(:,22))
    max(dataset(:,26))-min(dataset(:,26))
    max(dataset(:,30))-min(dataset(:,30))
    max(dataset(:,34))-min(dataset(:,34))
    max(dataset(:,38))-min(dataset(:,38))
];

scatter(Rfsr, deltaT*1000, 'LineWidth',2);

% axis([1000 100000 10e-5 10e3]);
xticks([1000 10000 100000]);
xticklabels({'1k', '10k', '100k'});

grid on 
grid minor
xlabel('Force Sensitive Resistor R_{FSR} (\Omega)','FontSize', 20)
% title('Force Sensitive Resistor vs Error','FontSize', 20)
ylabel('Delta T (us)','FontSize', 20)


