clc;clear;
%% range fonksiyonu
1:5 % 1 den 5 e kadar dizi 

0:2.5:8 % artis miktari 2.5

%% linspace
% sayilari n parçaya bölüyor 8 dediysem 1 den 10 a kadar 8 eşit parçaya 
% bölüyo
linspace(1, 10, 8) 

%% for loop
for i = 1:10
    fprintf("%d ", i)
end

%% while loop
c = 0;
while c < 10
    fprintf("%d ", c)
    c = c + 1;
end
