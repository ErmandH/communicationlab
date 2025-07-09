Yüksek geçiren filtre (HPF) için `buttord` fonksiyonu kullanımı tersine çevrilir. İşte SSB modülasyonu bağlamında yüksek geçiren filtre nasıl tanımlanır:
Search files...
Read file: dokumanlar/IIR_filtreTasarimi/iir_filterDesign_chebyHP.m

Yüksek geçiren filtre (HPF) için `buttord` fonksiyonu kullanımı alçak geçiren filtrenin tersine çevrilir. SSB modülasyonu bağlamında HPF'nin farklı kullanım senaryoları vardır:

## 1. DC ve Düşük Frekanslı Gürültü Bastırma İçin HPF:

```matlab
% Problem parametreleri
fs = 1000;  % Örnekleme frekansı
f1 = 20;    % Hz (en düşük mesaj frekansı)
f2 = 30;    % Hz  
fc = 200;   % Hz (taşıyıcı frekans)

% HPF parametreleri (DC ve düşük frekanslı gürültü bastırma)
ws = 5 / (fs/2);    % Durdurulan bant (bastırılacak frekanslar)
wp = 15 / (fs/2);   % Geçiş bandı (geçirilecek frekanslar)
Rp = 3;             % Geçiş bandı dalgalanması (dB)
Rs = 40;            % Durdurulan bant zayıflatması (dB)

% NOT: HPF için ws < wp olmalı (LPF'nin tersine)
[n, Wn] = buttord(wp, ws, Rp, Rs);
[b, a] = butter(n, Wn, 'high');
```

## 2. SSB Modülasyonunda Alt Yan Bant Bastırma İçin HPF:

```matlab
% SSB'de alt yan bandı bastırma
ws = 180 / (fs/2);  % fc-30 Hz altını bastır
wp = 200 / (fs/2);  % fc Hz'den itibaren geçir
Rp = 3;
Rs = 40;

[n, Wn] = buttord(wp, ws, Rp, Rs);
[b, a] = butter(n, Wn, 'high');
```

## 3. Genel HPF Parametreleri:

**Parametre Farkları:**
- **LPF**: `ws > wp` (yüksek frekansları bastır)
- **HPF**: `ws < wp` (düşük frekansları bastır)

```matlab
% HPF için genel format
wp = geçiş_frekansı / (fs/2);      % Geçirmek istediğimiz en düşük frekans
ws = durdurulan_frekansı / (fs/2); % Bastırmak istediğimiz en yüksek frekans

% ws < wp olmalı!
[n, Wn] = buttord(wp, ws, Rp, Rs);
[b, a] = butter(n, Wn, 'high');  % 'high' parametresi önemli!
```

## 4. Pratik Örnek - DC Bastırma:

```matlab
% DC ve çok düşük frekanslı bileşenleri bastırmak için
fs = 1000;
ws = 1 / (fs/2);     % 1 Hz altını bastır (DC dahil)
wp = 10 / (fs/2);    % 10 Hz'den itibaren geçir
Rp = 1;              % Geçiş bandında 1 dB dalgalanma
Rs = 60;             % 60 dB bastırma

[n, Wn] = buttord(wp, ws, Rp, Rs);
[b, a] = butter(n, Wn, 'high');

% Filtreleme
m_filtered = filter(b, a, m);
```

## Kullanım Alanları:

1. **DC Bastırma**: Demodülasyon sonrası DC bileşenini kaldırma
2. **Gürültü Bastırma**: Düşük frekanslı gürültüleri temizleme  
3. **SSB Filtreleme**: Modülasyon sırasında istenmeyen yan bandı bastırma
4. **Sinyal Ön İşleme**: Ana işlemeden önce istenmeyen düşük frekansları temizleme

HPF'nin en büyük avantajı, mesaj sinyalinin frekans bandını koruyarak sadece istenmeyen düşük frekanslı bileşenleri bastırmasıdır.