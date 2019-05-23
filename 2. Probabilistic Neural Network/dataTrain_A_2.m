clear;
clc;
close all;

%baca data excel dan menentukan isi yang ingin dibaca
dataTrain = csvread ('data_train_PNN.csv');
jumlahAtribut = size(dataTrain,2)-1;
data_kelas = dataTrain(:,jumlahAtribut+1);
dt = dataTrain(:,1:jumlahAtribut);

%proses klasifikasi
dt_0 = dt(find(data_kelas==0),:); 
dt_1 = dt(find(data_kelas==1),:); 
dt_2 = dt(find(data_kelas==2),:);

figure
scatter3(dt_0(:,1),dt_0(:,2),dt_0(:,3),'r*');
hold on
scatter3(dt_1(:,1),dt_1(:,2),dt_1(:,3),'g*');
hold on
scatter3(dt_2(:,1),dt_2(:,2),dt_2(:,3),'b*');
hold off