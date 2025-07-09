clc,clear, close all;
pkg load signal
fs=10000;
wp=2500/(fs/2);
ws=3900/(fs/2);
Rp=3;
% Rs=?  n=2
% [n,Wn] = buttord(Wp,Ws,Rp,Rs)
% [b,a] = butter(n,Wn)
% [b,a] = butter(n,Wn,ftype)
Rs=17.79;
[n,Wn] = buttord(wp,ws,Rp,Rs);
[b,a] = butter(n,Wn)

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







