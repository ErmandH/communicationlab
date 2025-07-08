pkg load signal;

clc;clear; close all;

fs = 500;
ts= 1/fs;
t = 0:ts:1-ts;

s1 = sin(2*pi*20*t);
s2 = sin(2 * pi * 100 *t);

s_new = s1 .* s2;
s_new = s_new + s2;

% Frekans bölgesi için gerekli tanımlamalar
f = linspace(-fs/2, fs/2, length(s1) + 1);
f = f(1:end-1);

% bandpass filter
Wn_bp = [50 150] / (fs / 2);
n = 3;

[b1, a1] = butter(n, Wn_bp,"bandpass");
[H1_bp, ~] = freqz(b1, a1, fs, "whole");

% ilk grafik
S_NEW = abs(fftshift(fft(s_new))) / length(s_new);
figure;
stem(f, S_NEW);
xlabel("f (Hz)");
grid on;
hold on;
axis([-250 250 0 1]);
plot(f, abs(fftshift(H1_bp)),"LineWidth", 2);

% bpf ile filtreleme
s_filtered1 = filter(b1,a1, s_new);

% 2s2 ile toplama
s_filtered1 = s_filtered1 .* 2 .* s2;

% low pass filtre olusturma
Wn_lp = 50 / (fs / 2);
n = 2;

[b2, a2] = butter(n, Wn_lp, "low");

% low pass uygula
s_filtered2 = filter(b2,a2, s_filtered1);

% dc iptal et
s_filtered2 = s_filtered2 - mean(s_filtered2);

% s1 ve s_filtered2 grafigi
figure;
plot(t, s1,"--r");
hold on;
plot(t, s_filtered2);
grid on;
xlim([0 0.2])
ylim([-1.5 1.5])
legend('Çıkış Sinyali', 'Giriş Sinyali (s1)')