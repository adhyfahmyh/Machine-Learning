clc;
clear;

%load data matriks R
%Load data reward setiap aksi yang dibuat manual
%Q diset 0
matriksR='DataTugasML3.txt'
reward = xlsread('reward.xlsx','B2:E101')
sz = size(reward)
Q = zeros(sz)

%lakukan Q-learning
[current] = Q_Learning(reward, Q)

