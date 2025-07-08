clc;clear; close all;

fs = 10^3; ts = 1 / fs;
t = 0:ts:1-ts;

f1 = 20; f2 = 30;
fc = 200;
mod_i = 0.9; % modülasyon indisi

m = (2*cos(2*pi*f1*t) + 5*cos(2*pi*f2*t)) / 5;
c = cos(2*pi*fc*t);
f_am = (1 + mod_i .* m) .* c;
%% Frekans bölgesi (a şıkkı)
f = linspace(-fs/2, fs/2, length(m) + 1); % [fs/2 fs/2]
f = f(1: end-1); % [fs/2 fs/2)

C = fftshift(abs(fft(c))) / length(c);
M = fftshift(abs(fft(m))) / length(m);
F_am = fftshift(abs(fft(f_am))) / length(f_am);

figure;
subplot 311
grid on
plot(f, C)
title("|C(f)|"); xlabel("f (Hz)"); ylabel("Genlik")

subplot 312
grid on
plot(f, M)
title("|M(f)|") ; xlabel("f (Hz)"); ylabel("Genlik")

subplot 313
grid on
plot(f, F_am)
title("|Fam(f)|") ; xlabel("f (Hz)"); ylabel("Genlik")

%% Demodülasyon (b) şıkkı
% diyot davranışı fam(find(fam < 0)) = 0
f_am_copy = f_am;
f_am(f_am < 0) = 0;

v0 = f_am;

% LPF olusturma
% LPF derecesi
lp_n = 4;
% LPF Normalize Edilmis Kesim Frekansi
lp_Wn = 40 / (fs / 2);

[b, a] = butter(lp_n, lp_Wn,"low");

% LPF ile filtreleme islemi
f_am = filter(b, a, f_am);
v1 = f_am;
% DC bileşenini iptal etme (mean değerini çıkarma)
f_am = f_am - mean(f_am); % demodüle edilmiş final işareti

figure;
subplot 211
plot(t, f_am_copy)
title("fam(t)") ; xlabel("t (s)"); ylabel("Genlik")

subplot 212
plot(t, m)
hold on
plot(t, f_am)
legend("Mesaj İşareti", "Demodüle İşaret", "NumColumns", 2)

%% c şıkkı
V0 = fftshift(abs(fft(v0)) / length(v0));
figure;grid on;
subplot 311
plot(f, V0);
[H, ~] = freqz(b, a, length(v0), "whole");
hold on;
plot(f, fftshift(abs(H)));
legend("|VO(f)|", "|H(f)|", "NumColumns", 2)
% d şıkkı
V1 = fftshift(abs(fft(v1)) / length(v1));
subplot 312
plot(f, V1)
title("|V1(f)|") ; xlabel("f (Hz)"); ylabel("Genlik")

subplot 313
M_final = fftshift(abs(fft(f_am)) / length(f_am));
plot(f, M_final)
title("|M(f)|") ; xlabel("f (Hz)"); ylabel("Genlik")

