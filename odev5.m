clc;clear;close all;
Ac=1;Am=1;
fm = 10;fc = 200; fs=5000;kp=1;
ts = 1/fs;
t = 0:ts:1-ts;

m = Am*cos(2*pi*fm*t);
c = Ac*cos(2*pi*fc*t);
s_pm = Ac*cos(2*pi*fc*t + kp .* m);



f = linspace(-fs/2, fs/2, length(m) + 1); % [fs/2 fs/2]
f = f(1: end-1); % [fs/2 fs/2)

z1 = hilbert(s_pm);
z2 = z1 .* exp(-1j* 2 * pi*fc*t);

z2_faz = phase(z2);

m_hat = z2_faz ./ kp;
%% Figure-1
figure;
subplot 311
grid on
plot(t, m)
title("m(t)"); xlabel("t"); ylabel("Genlik")

subplot 312
grid on
plot(t, c)
title("c(t)"); xlabel("t"); ylabel("Genlik")

subplot 313
grid on
plot(t, s_pm)
title("s_pm(t)"); xlabel("t"); ylabel("Genlik")

%% Figure-2
S_PM = fftshift(fft(s_pm)) / length(s_pm);
Z1 = fftshift(fft(z1)) / length(z1);
Z2 = fftshift(fft(z2)) / length(z2);

figure;
subplot 311
grid on
plot(f, S_PM)
title("|S_PM(f)|"); xlabel("f"); ylabel("Genlik")

subplot 312
grid on
plot(f, Z1)
title("|Z1(f)|"); xlabel("f"); ylabel("Genlik")

subplot 313
grid on
plot(f, Z2)
title("|Z2(f)|"); xlabel("f"); ylabel("Genlik")

%% Figure-3

figure;
grid on
plot(t, m)
xlabel("t"); ylabel("Genlik")
hold on
plot(t, m_hat)
legend("Mesaj İşareti", "Demodüle İşaret", "NumColumns", 2)


