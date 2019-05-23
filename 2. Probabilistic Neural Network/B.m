clear;
clc;
close all;

dataTrain = csvread ('data_train_PNN.csv');
dataValid = csvread ('data_test_PNN.csv');

jumlahAtribut = size(dataTrain,2)-1;

data_kelas = dataTrain(:,jumlahAtribut+1);

dt = dataTrain(:,1:jumlahAtribut);

%klasifikasi data
dt_0 = dt(find(data_kelas==0),:); 
dt_1 = dt(find(data_kelas==1),:); 
dt_2 = dt(find(data_kelas==2),:);

%pembuatan scatter plot
figure
scatter3(dt_0(:,1),dt_0(:,2),dt_0(:,3),'r*');
hold on
scatter3(dt_1(:,1),dt_1(:,2),dt_1(:,3),'g*');
hold on
scatter3(dt_2(:,1),dt_2(:,2),dt_2(:,3),'b*');
hold off

%perulangan untuk perhitungan probabilistic density function
s = 1;
for i=1:size(dataValid)
    for j=1:size(dt_0)
        g(i,1) = (exp(-(abs((dataValid(i,1)-dt_0(j,1)^2)+((dataValid(i,2)-dt_0(j,2))^2)+((dataValid(i,3)-dt_0(j,3))^2))/2*s^2)))
        f(i,1) = sum(g(i,1))/size(dt_0,1);
    end
    for k=1:size(dt_1)
        g(i,2) = (exp(-(abs((dataValid(i,1)-dt_1(k,1))^2)+((dataValid(i,2)-dt_1(k,2))^2)+((dataValid(i,3)-dt_1(k,3))^2))/2*s^2))
        f(i,2) = sum(g(i,2))/size(dt_1,2);
    end
    for l=1:size(dt_2)
        g(i,3) = (exp(-(abs((dataValid(i,1)-dt_2(l,1))^2)+((dataValid(i,2)-dt_2(l,2))^2)+((dataValid(i,3)-dt_2(l,3))^2))/2*s^2))
        f(i,3) = sum(g(i,3))/size(dt_2,3);
    end

%perulangan untuk mencari max dari f
for i = 1:size(f)
    fmax(i,1)=max(f(i,1:3))
    if (find(fmax(i,1) == f(i,1)))
        hasil(i,1)=0;
    elseif (find(fmax(i,1) == f(i,2)))
        hasil(i,1)=1;
    elseif (find(fmax(i,1) == f(i,3)))
        hasil(i,1)=2;
    end
end
end

%masukkan data hasil kedalam file Prediksi.txt
a=hasil.';
fid=fopen('Prediksi.txt','wt');
fprintf(fid, '%1s\r\n');
fprintf(fid, '%f\r\n',a);
fclose(fid);
