clc;clear;close all;
Ac=1;Am=1;
fm = 10;fc = 200; fs=5000;kf=80*2*pi;
ts = 1/fs;
t = 0:ts:1-ts;
% mesaj işareti
m = Am*cos(2*pi*fm*t);
% taşıyıcı
c = Ac*cos(2*pi*fc*t);

% mesajın integrali
integral_m = cumsum(m) * ts;

% frekans modüleli işaret
s_fm = Ac*cos(2*pi*fc*t + kf * integral_m);



f = linspace(-fs/2, fs/2, length(m) + 1); % [fs/2 fs/2]
f = f(1: end-1); % [fs/2 fs/2)

z1 = hilbert(s_fm);
z2 = z1 .* exp(-1j* 2 * pi*fc*t);

z2_faz = phase(z2);

z2_turev = diff(z2_faz) * fs;

% demodüleli işaret
m_hat = z2_turev / kf;
%% Figure-1
figure;
subplot 311
grid on
plot(t, m)
title("m(t)"); xlabel("t (sn)"); ylabel("Genlik")

subplot 312
grid on
plot(t, c)
title("c(t)"); xlabel("t (sn)"); ylabel("Genlik")

subplot 313
grid on
plot(t, s_fm)
title("s_fm(t)"); xlabel("t (sn)"); ylabel("Genlik")

%% Figure-2
s_fm = abs(fftshift(fft(s_fm))) / length(s_fm);
Z1 = abs(fftshift(fft(z1))) / length(z1);
Z2 = abs(fftshift(fft(z2))) / length(z2);

figure;
subplot 311
grid on
plot(f, s_fm)
title("|s_fm(f)|"); xlabel("f (Hz)"); ylabel("Genlik")

subplot 312
grid on
plot(f, Z1)
title("|Z1(f)|"); xlabel("f (Hz)"); ylabel("Genlik")

subplot 313
grid on
plot(f, Z2)
title("|Z2(f)|"); xlabel("f (Hz)"); ylabel("Genlik")

%% Figure-3
t_hat = t(1: end-1);
figure;
grid on
plot(t, m)
xlabel("t (sn)"); ylabel("Genlik")
hold on
plot(t_hat, m_hat)
legend("Mesaj İşareti", "Demodüle İşaret", "NumColumns", 2)


