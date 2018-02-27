
Rfsr=10e3;
C=1e-12;
VBATT = 10;
syms t
Vc = VBATT-VBATT*(2.^(-t/(Rfsr*C)));

diff(Vc);

figure
plot(t,Vcc);
grid on

axis([0 1e-7 0 10])
set(gca,'fontsize',12)