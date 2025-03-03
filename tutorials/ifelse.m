clc;clear;
%% if-else
input1 = input("y/N:", "s");

if (input1 == "y" || input1 == "Y")
    disp("Yes dediniz")
elseif (input1 == "n" || input1 == "N" )
     disp("No dediniz")
else
    disp("Yanlış input")
end