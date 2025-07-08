%% Frekans ve sinyal tanimlamalari

% örnekleme frekansı
fs = 500;
ts = 1/fs;
t = 0:ts:1-ts;


f1 = 20; f2 = 100;

s1 = sin(2*pi*f1*t);
s2 = sin(2*pi*f2*t);
% sinyalleri carpim
s = s1 .* s2;
% sinyalleri toplama
s = s + s2;

% frekans araligini olusturma
f = linspace(-fs/2, fs/2, length(s) + 1); % [fs/2 fs/2]
f = f(1: end-1); % [fs/2 fs/2)

% subplot 232 => satir sayisi, sutun sayisi, cizilecek olanin indexi

%% sinyallerin fourier donusumu
S = abs(fftshift(fft(s))) / length(s);
figure('Name',"Spektrum Analizör");
stem(f, S) % ayrik gosterim icin
xlabel("Frekans (Hz)")
ylabel("Genlik")
grid on;
ylim([0 1]) % genlik eksenini 0-1 arasinda olcekle

%% BPF olusturma
% BPF derecesi
bp_n = 3;
% BPF Normalize Edilmis Kesim Frekanslari
bp_Wn = [50 150] / (fs / 2);

[b1, a1] = butter(bp_n, bp_Wn,"bandpass");

% BPF nin frekans cevabini alma
[H1, ~] = freqz(b1, a1, fs, "whole");
% S sinyali ile ayni grafikte gostermek icin
hold on
plot(f, abs(fftshift(H1)), "r", "LineWidth", 2)
legend('S sinyali', 'BPF')
%% BPF ile filtreleme islemi
s_filtered1 = filter(b1, a1, s);

% 2*s2 ile carpilmis sinyal
s_filtered1 = s_filtered1 .* 2 .* s2;

%% LPF olusturma
% LPF derecesi
lp_n = 3;
% LPF Normalize Edilmis Kesim Frekansi
lp_Wn = 50 / (fs / 2);

[b2, a2] = butter(lp_n, lp_Wn,"low");

% LPF ile filtreleme islemi
s_filtered2 = filter(b2, a2, s_filtered1);

% DC bileşenini iptal etme (mean değerini çıkarma)
s_filtered_dc = s_filtered2 - mean(s_filtered2);

% Osiloskopta gösterme
figure('Name',"Osiloskop");
plot(t, s_filtered_dc, 'b', 'LineWidth', 1.5);
xlabel('Zaman (s)');
ylabel('Genlik');
title('Osiloskop');
grid on;

hold on
plot(t, s1, 'r--', 'LineWidth', 1.5);
xlim([0 0.2])
ylim([-1.5 1.5])
legend('Çıkış Sinyali', 'Giriş Sinyali (s1)')