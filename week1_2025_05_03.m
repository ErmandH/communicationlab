%% Uygulama
clc; clear; close all;
%B = [ 0 5 5 ; 70 8 7 ; 10 1 3]
% save B katsayilar // değişkeni katsayilar.mat olarak kaydetmek için

load katsayilar.mat

disp(B * 2)

triu_b = triu(B)
tril_b = tril(B)

C = [B zeros(3,2)]
%% structure array
person.name = "Ermand";
person.surname = "Haruni";
person.phone = "05394111175";
disp(person)