clc;clear; close all;
fm = 50; fc=150; fs = 1000;
Ac=2;

ts = 1/fs;          % Zaman Aralığı
t = 0:ts:1-ts;
c = Ac*cos(2*pi*fc*t);
m = cos(2*pi*fm* t);

x_am = (Ac + m) .* cos(2*pi* fc* t);
X_AM = abs(fftshift(fft(x_am))) / length(x_am);

% frekans
f = linspace(-fs/2, fs/2, length(x_am) + 1); % [-fs/2 fs/2]
f = f(1:end-1); % [-fs/2 fs/2)

x_am2 = x_am .^ 2;
X_AM2 = abs(fftshift(fft(x_am2))) / length(x_am2);
%% Low Pass Filtre Tasarımı

wp = 0 / (fs / 2);
ws = 100 / (fs / 2);



% Düşük geçiren filtre tasarımı
lp_n = 9; % LPF derecesi
lp_Wn = 60 / (fs/2); % Normalize edilmiş kesim frekansı

[b, a] = butter(lp_n, lp_Wn, 'low');
[H, ~] = freqz(b, a, length(x_am), 'whole');
H_shifted = fftshift(abs(H));

demod = filter(b,a, x_am2);

demod = demod - mean(demod);
demod = demod ./ Ac;

%% a şıkkı
figure;
subplot 311;
plot(t,m); grid on;
xlabel("m(t)"); title("Mesaj İşareti"); ylabel("Genlik");

subplot 312;
plot(t,c); grid on;
xlabel("c(t)"); title("Taşıyıcı İşaret"); ylabel("Genlik");

subplot 313;
plot(t,x_am); grid on;
xlabel("x_am(t)"); title("Modüleli İşaret"); ylabel("Genlik");
%% b şıkkı
figure;
axis([-500 500 0 1.2])
plot(f, X_AM2);grid on;
hold on
plot(f, H_shifted, "LineWidth", 3);
legend("Karesi Alınmış İşaret |XAM^2(f)|","Alçak Geçiren Filtre |H(f)|")

%% c şıkkı
figure;

plot(t, m);grid on;
hold on
plot(t, demod);
legend("Mesaj İşareti","Demodüle İşaret")
xlim([0 0.2]);
ylim([-1.5 1.5]);