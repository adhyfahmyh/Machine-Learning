clear;
clc;
close all;

dataTrain = csvread ('data_train_PNN.csv');

jumlahAtribut = size(dataTrain,2)-1;

data_kelas = dataTrain(:,jumlahAtribut+1);

dt = dataTrain(:,1:jumlahAtribut);

figure
scatter3(dt(:,1),dt(:,2),dt(:,3),'r*');
hold off