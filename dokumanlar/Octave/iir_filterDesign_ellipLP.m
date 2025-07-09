clc,clear, close all;
pkg load signal
fs=10000;
wp=2500/(fs/2);
ws=3900/(fs/2);
Rp=.3; %3 .3
Rs=60;

[n,Wp] = ellipord(wp,ws,Rp,Rs);
[b,a] = ellip(n,Rp,Rs,Wp);

% [H,w] = freqz(b,a,n)
% [H,f] = freqz(b,a,n,fs)
% [H,w] = freqz(b,a,n,'whole')
% [H,f] = freqz(b,a,n,fs,'whole')
rsltn=500;
[H,f] = freqz(b,a,rsltn,fs);

figure
subplot(2,1,1)
plot(f,abs(H));
subplot(2,1,2)
plot(f,angle(H));







