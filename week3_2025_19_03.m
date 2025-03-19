clc, clear;

%% Sinyal Üretimi
% IIR -> Infinite Impulse Response: geribeslemeli sistemlerde olur
% FIR -> Finite Impulse Response

f1 = 15;
f2 = 60;
f3 = 90;

fs = 1000;

ts = 1/fs;

t = 0:ts:1-ts;

s1 = 2*cos(2*pi*f1*t);
s2 = cos(2*pi*f2*t);
s3 = 2*cos(2*pi*f3*t);
s = s1 + s2 + s3;

S = fft(s);

f = -fs/2:fs/2;
f(end) = [];

figure;
plot(f, abs(fftshift(S)) / fs);
xlim([-100 100]);

%% Low Pass Filtre Tasarımı

wp = 20 / (fs / 2);
ws = 50 / (fs / 2);

Rp = 1; % 1db zayıflatma
Rs = 80; % 80db bastırma

% n = filtrenin orderı derecesi
% Wn = kesim frekansı
[n, Wn] = buttord(wp,ws, Rp,Rs);
% transfer fonksiyonunu çıkardı
[b1, a1] = butter(n, Wn);

[H1, ~] = freqz(b1, a1, fs, "whole");

hold on
plot(f, abs(fftshift(H1)), "r")


%% Band Pass Filter Tasarımı

wp_bp = [55 65] / (fs / 2);
wp_sp = [40 80] / (fs / 2);

Rp_bp = 3;
Rs_bp = 40;

[n_bp, Wn_bp] = buttord(wp_bp, wp_sp, Rp_bp, Rs_bp);

[b1_bp, a1_bp] = butter(n_bp, Wn_bp);
[H1_bp, ~] = freqz(b1_bp, a1_bp, fs, "whole");

hold on
plot(f, abs(fftshift(H1_bp)), "g")
xlabel("frenaks (Hz)")
ylabel("Genlik")
legend("|S(f)|", "LPF", "BPF", "Location","northeastoutside")


s1_hat = filter(b1, a1, s);
figure;
plot(t,s,t,s1_hat)
xlim([0 0.2])

s2_hat = filter(b1_bp, a1_bp, s);
figure
plot(t,s, t, s2_hat)
xlim([0 0.2])