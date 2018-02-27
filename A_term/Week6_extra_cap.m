


Rfsr1 = [989.3
1964.5
2933
6202
8081
9958
19786
29717
80506
99668];


error1_onecap = [38.26254
15.11458
10.11219
3.02947
1.84080
1.06747
0.98975
1.38877
0.99176
1.29684];

time_to_meas = [0.55791
0.92780
1.33688
2.63892
3.36622
4.11063
8.01947
12.02435
32.57803
40.26365];

Rfsr_capadded_2_25uf = [
    989.3
1193
1481
1964.5
2933
5059
6202
8081
9878
19786
29717
50382
80506
99668];

error_capadded_2_25uf = [
    18.16583977
16.07651051
11.21402995
7.188833732
5.675714465
3.638750329
2.868704471
1.135910171
0.788336857
0.271235197
0.207932817
0.300575609
0.275230521
0.282243761];

time_capadded_2_25uf = [
   2.051901995
2.344299296
2.878470951
3.768595
5.487300763
9.332505869
11.31302708
14.64695628
17.74652113
35.40848269
53.10909028
89.7048081
143.4651112
177.679344];

Rfsr_capadded_4_5uf1 = [989.3
1481
1964.5
2933
6202
8081
9878
19786
29717
50382
80445
99668];

error_4_5uf1 = [12.69176648
10.3750696
6.851511255
5.474953442
2.16326076
0.830677019
0.689777745
0.288707846
0.259129308
0.2392671
0.230279275
0.292145308];

Rfsr_4_5uf2 = [989.3
1193
1964.5
2933
5059
8081
9878
29717
80445
99668];

time_4_5uf2 = [
    3.501229167
4.131133013
6.658511619
9.659709936
16.2763129
25.88540184
31.75444471
94.56140385
255.514383
316.5350585];

subplot(2,1,1)
loglog(Rfsr1, error1_onecap,'o','LineWidth',2);

hold on
loglog(Rfsr_capadded_2_25uf, error_capadded_2_25uf,'b','LineWidth',2);

hold on
loglog(Rfsr_capadded_4_5uf1, error_4_5uf1,'-o','LineWidth',2);

grid on
grid minor

axis([900 100000 0.01 1e2]);
xticks([1000 10000 100000]);
xticklabels({'1k', '10k', '100k'});
yticks([0.01 1 5 10 30 100]);
yticklabels({'0.01','1', '5', '10','30', '100'});

xlabel('Applied Force Sensitive Resistor R_{FSR} (\Omega)','FontSize', 16)
title('Force Sensitive Resistor vs Error','FontSize', 20)
ylabel('Measument Error (%)','FontSize', 16)
% lgd = legend('Experiment','Simulation');
% lgd.FontSize = 16;


%calculation
%Set Test Condition

delta_t2 = 32e-6;
C2 = 0.64e-6+4.5e-6;
Rref = 10000;
Rfsr = 1e3:100:100e3;

% delta_t1 = (0.0066.*Rfsr+54).*0.000001;
delta_t1 = 90e-6;
C1 = 0.64e-6;
%Computation Result
error1 = (delta_t1./C1).*(1./Rfsr+1/Rref)*100;
hold on
loglog(Rfsr, error1,'--', 'LineWidth',2);

% error2 = (delta_t1./C2)*(1./Rfsr+1/Rref)*100;
% hold on
% loglog(Rfsr, error2,':', 'LineWidth',2);






subplot(2,1,2)
loglog(Rfsr1, time_to_meas,'o','LineWidth',2);

hold on
loglog(Rfsr_capadded_2_25uf, time_capadded_2_25uf,'b','LineWidth',2);

hold on
loglog(Rfsr_4_5uf2, time_4_5uf2,'r','LineWidth',2);

grid on
grid minor

axis([900 110000 0 500]);
% xticks([1000 10000 100000]);
% xticklabels({'1k', '10k', '100k'});
% yticks([1 5 10 50 100]);
% yticklabels({'1', '5', '10','50','100'});

xlabel('Applied Force Sensitive Resistor R_{FSR} (\Omega)','FontSize', 16)
title('Force Sensitive Resistor vs Time to take measurement','FontSize', 20)
ylabel('Time To Take Measurement (ms)','FontSize', 16)
% lgd = legend('Experiment','Simulation');
% lgd.FontSize = 16;









