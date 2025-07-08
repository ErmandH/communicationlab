clc; clear; close all;

% Tek Yan Bant Modülasyonu

% Frekans ve zaman tanımlamaları
fs = 1000; % Örnekleme frekansı 1000 Hz
ts = 1/fs;
t = 0:ts:1-ts;

% Frekans değerleri
f1 = 20; % Hz
f2 = 30; % Hz
f3 = 200; % Hz

% İşaret tanımlamaları
m = 2*cos(2*pi*f1*t) + 5*cos(2*pi*f2*t); % mesaj işareti
c = cos(2*pi*f3*t); % taşıyıcı işareti

% Hilbert dönüşümü ile m_hat hesabı
m_hat = imag(hilbert(m));

% Tek Yan Bant (SSB) Modülasyonu
x_tyb = m.*c + m_hat.*sin(2*pi*f3*t);

% Frekans bölgesi için gerekli tanımlamalar
f = linspace(-fs/2, fs/2, length(m) + 1);
f = f(1:end-1);

% a) |C(f)|, |M(f)| ve |X_tyb(f)| genlik izgelerinin çizdirilmesi
C = fftshift(abs(fft(c))) / length(c);
M = fftshift(abs(fft(m))) / length(m);
X_tyb = fftshift(abs(fft(x_tyb))) / length(x_tyb);

figure('Name', 'Şekil 1');
subplot(3,1,1)
plot(f, C)
xlabel('f (Hz)')
ylabel('Genlik')
title('|C(f)|')
xlim([-f3/2, f3/2])
grid on

subplot(3,1,2)
plot(f, M)
xlabel('f (Hz)')
ylabel('Genlik')
title('|M(f)|')
xlim([-f3/2, f3/2])
grid on

subplot(3,1,3)
plot(f, X_tyb)
xlabel('f (Hz)')
ylabel('Genlik')
title('|X_{tyb}(f)|')
xlim([-f3/2, f3/2])
grid on

% b) Modüleli işaret x_tyb(t)'yi çizdirme
figure('Name', 'Şekil 2');
plot(t, x_tyb)
xlabel('t (s)')
ylabel('Genlik')
title('Modüleli İşaret x_{tyb}(t)')
xlim([0, 0.1])
grid on

% c) d(t) ve düşük geçiren filtrenin genlik izgesi
% Demodülasyon için çarpma işlemi
d = x_tyb .* c;
D = fftshift(abs(fft(d))) / length(d);

% Düşük geçiren filtre tasarımı
lp_n = 4; % LPF derecesi
lp_Wn = 40 / (fs/2); % Normalize edilmiş kesim frekansı

[b, a] = butter(lp_n, lp_Wn, 'low');
[H, ~] = freqz(b, a, length(d), 'whole');
H_shifted = fftshift(abs(H));

figure('Name', 'Şekil 3');
plot(f, D)
hold on
plot(f, H_shifted, 'r', 'LineWidth', 2)
xlabel('f (Hz)')
ylabel('Genlik')
title('|D(f)| ve Alçak Geçiren Filtrenin Genlik İzgesi')
legend('|D(f)|', '|H(f)|')
xlim([-f3/2, f3/2])
grid on

% d) Demodüle işareti elde etme 
% Alçak geçiren filtre uygulama
m_demod = filter(b, a, d);
M_demod = fftshift(abs(fft(m_demod))) / length(m_demod);

figure('Name', 'Şekil 4');
plot(f, M)
hold on
plot(f, M_demod)
xlabel('f (Hz)')
ylabel('Genlik')
title('|M(f)| ve |M_{demod}(f)| Genlik İzgeleri')
legend('|M(f)|', '|M_{demod}(f)|')
xlim([-f3/2, f3/2])
grid on

% e) Mesaj işareti m(t) ile demodüle edilmiş işaret m_demod(t)'yi çizdirme
figure('Name', 'Şekil 5');
plot(t, m)
hold on
plot(t, m_demod)
xlabel('t (s)')
ylabel('Genlik')
title('m(t) ve Demodüle Edilmiş İşaret m_{demod}(t)')
legend('m(t)', 'm_{demod}(t)')
xlim([0, 0.1])
grid on

% f) Üst yan bant modülasyonu için
% Üst yan bant modülasyonu
x_tyb_ust = m.*c - m_hat.*sin(2*pi*f3*t);

% Demodülasyon
d_ust = x_tyb_ust .* c;
m_demod_ust = filter(b, a, d_ust);

% Genlik izgeleri
X_tyb_ust = fftshift(abs(fft(x_tyb_ust))) / length(x_tyb_ust);
D_ust = fftshift(abs(fft(d_ust))) / length(d_ust);
M_demod_ust = fftshift(abs(fft(m_demod_ust))) / length(m_demod_ust);

% Üst yan bant modülasyonu sonuçları
figure('Name', 'Şekil 6 - Üst Yan Bant Modülasyonu');
subplot(2,2,1)
plot(f, X_tyb_ust)
xlabel('f (Hz)')
ylabel('Genlik')
title('|X_{tyb\_ust}(f)|')
xlim([-f3/2, f3/2])
grid on

subplot(2,2,2)
plot(t, x_tyb_ust)
xlabel('t (s)')
ylabel('Genlik')
title('x_{tyb\_ust}(t)')
xlim([0, 0.1])
grid on

subplot(2,2,3)
plot(f, D_ust)
hold on
plot(f, H_shifted, 'r', 'LineWidth', 2)
xlabel('f (Hz)')
ylabel('Genlik')
title('|D_{ust}(f)| ve |H(f)|')
xlim([-f3/2, f3/2])
grid on

subplot(2,2,4)
plot(t, m)
hold on
plot(t, m_demod_ust)
xlabel('t (s)')
ylabel('Genlik')
title('m(t) ve m_{demod\_ust}(t)')
legend('m(t)', 'm_{demod\_ust}(t)')
xlim([0, 0.1])
grid on 