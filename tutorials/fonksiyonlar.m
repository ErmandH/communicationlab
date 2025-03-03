clc;clear;
%% input kullanimi
kenar1 = input("Kenar 1: ");
kenar2 = input("Kenar 2: ");
string_input = input("Str input", "s"); % stringe cevrilmesini istiyosak
area = kenar1 * kenar2;

fprintf("Alan: %d", area);
%% fonksiyonlar
% tek input ise sadece result da yapabilirim
function [result] = topla(arg1, arg2)
% result = output argumanlari
result = arg1 + arg2;
end

disp(topla(3,5))

function [retArg1, retArg2] = cokluOutput(arg1, arg2)
retArg1 = arg1 ^ 2;
retArg2 = arg2 ^ 2;
end

[retVal1, retVal2] = cokluOutput(4, 5)

