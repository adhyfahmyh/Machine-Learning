%Adhyfa Fahmy Hidayat
%1301154127
%IF3901
%% Import Data
dataTrain = csvread('TrainsetTugas2.csv');
dataTest = csvread('TestsetTugas2.csv');
X = dataTrain(:,1:2);
Y = dataTest(:,1:2);
% Visualisasi data dengan scatter
scatter(Y(:,1),Y(:,2));

%% Buat centroid random
[numRow , numCol] = size(X);
k = 7;
startCentroids = zeros(k,2);
startCentroids = X(randperm(numRow, k), :);

%% Fungsi kMeans dataTrain
% Definisi semua variabel yang dibutuhkan
[ numRow numCol ]   = size(X);
[ numK numkCol ]    = size(startCentroids);
change              = true;
i                   = 0;
tempCentroids       = startCentroids;
result              = X;
finalCentroids      = startCentroids;
listSSE             = [];

% Lakukan perulangan hingga centroid awal dan centroid akhir tidak berubah
    while (change == true )
        % Masukkan nilai centroid yang telah diupdate kedalam variabel
        % tempCentroids
        tempCentroids = finalCentroids;
        % Lakukan looping
        for i = 1:numRow
            % Set array kosong untuk menampung koordinat jarak minimum
            whoMin = [];
            % Lakukan looping untuk menghitung jarak tiap baris data
            % terhadap centroid awal
            for j = 1:numK
                sub = X(i,:) - finalCentroids(j,:);
                % Menghitung jarak menggunakan euclidean distance
                euclidean = sqrt(sum(sub.^2));
                whoMin = [whoMin; euclidean];
            end
            [~ , idx ] = min(whoMin);
            result(i,3) = idx;
        end
        % Lakukan perulangan untuk mengupdate centroid baru
        for i = 1:numK
            condition = result(:, 3) == i;
            finalCentroids(i,:) = mean(result(condition,1:2));
        end
%% Hitung nilai sse untuk mendapatkan nilai K yang optimum
  % Assign array awal
  listSSE = [];
  % Lakukan perulangan dari centroid yang paling optimum
  for i = 1:length(finalCentroids)
    % Cari label yang sama pada array hasil (nb: label yang dimaksud adalah
    % cluster)
    condition = result(:, 3) == i;
    dataCondition = result(condition,1:2);
    
    % Lakukan perulangan untuk setiap setiap kluster (pake rumus yang ada
    % di slide buat ngitung ssenya)
    for j=1:length(dataCondition)   
        sub = dataCondition(j,:) - finalCentroids(i,:);
        euclidean = sqrt(sum(sub.^2));
    end
    % hasilnya masukkan ke dalam variable listSSE
    listSSE = [listSSE ; euclidean];
    
  end
  % total semua nilai sse pada variabel sse
  resultSSE = sum(listSSE);

        % Lakukan pengecekan untuk nilai centroid yang telah diupdate
        % terhadap centroid awal. Jika nilai centroid akhir dan centroid
        % awal tidak berubah maka perulangan dihentikan dan program
        % diakhiri
        if ((tempCentroids == finalCentroids))
            change = false;
        end
    end

    
%% Fungsi kMeans dataTest
% Definisi semua variabel yang dibutuhkan
[ numRow numCol2  ]   = size(Y);
[ numK numkCol2 ]    = size(finalCentroids);
change2              = true;
l                   = 0;
tempCentroids2       = finalCentroids;
result2              = Y;
listSSE2             = [];

% Lakukan perulangan hingga centroid awal dan centroid akhir tidak berubah
    while (change2 == true )
        % Masukkan nilai centroid yang telah diupdate kedalam variabel
        % tempCentroids
        tempCentroids2 = finalCentroids;
        % Lakukan looping
        for l = 1:numRow
            % Set array kosong untuk menampung koordinat jarak minimum
            whoMin1 = [];
            % Lakukan looping untuk menghitung jarak tiap baris data
            % terhadap centroid awal
            for j = 1:numK
                sub1 = Y(l,:) - finalCentroids(j,:);
                % Menghitung jarak menggunakan euclidean distance
                euclidean1 = sqrt(sum(sub1.^2));
                whoMin1 = [whoMin1; euclidean1];
            end
            [~ , idx ] = min(whoMin1);
            result2(l,3) = idx;
        end
        % Lakukan perulangan untuk mengupdate centroid baru
        for l = 1:numK
            condition = result2(:, 3) == l;
            finalCentroids(l,:) = mean(result2(condition,1:2));
        end
%% Hitung nilai sse untuk mendapatkan nilai K yang optimum
  % Assign array awal
  listSSE2 = [];
  % Lakukan perulangan dari centroid yang paling optimum
  for l = 1:length(finalCentroids)
    % Cari label yang sama pada array hasil (nb: label yang dimaksud adalah
    % cluster)
    condition = result2(:, 3) == l;
    dataCondition = result2(condition,1:2);
    
    % Lakukan perulangan untuk setiap setiap kluster (pake rumus yang ada
    % di slide buat ngitung ssenya)
    for j=1:length(dataCondition)   
        sub1 = dataCondition(j,:) - finalCentroids(l,:);
        euclidean1 = sqrt(sum(sub1.^2));
    end
    % hasilnya masukkan ke dalam variable listSSE
    listSSE2 = [listSSE2 ; euclidean1];
    
  end
  % total semua nilai sse pada variabel sse
  resultSSE = sum(listSSE2);

        % Lakukan pengecekan untuk nilai centroid yang telah diupdate
        % terhadap centroid awal. Jika nilai centroid akhir dan centroid
        % awal tidak berubah maka perulangan dihentikan dan program
        % diakhiri
        if ((tempCentroids2 == finalCentroids))
            change2 = false;
        end
    end


%% Visualisasi centroids
label = [1:length(finalCentroids)]';

    rowsToSetBlue = label == 4;
    rowsToSetRed = label == 6;
    rowsToSetYellow = label == 5;
    rowsToSetMagenta = label == 7;
    rowsToSetGreen = label == 1;
    rowsToSetCyan = label == 2;
    rowsToSetBlack = label == 3;

    mlabelColors(rowsToSetBlue, 1) = 0;
    mlabelColors(rowsToSetBlue, 2) = 0;
    mlabelColors(rowsToSetBlue, 3) = 1;

    mlabelColors(rowsToSetRed, 1) = 1;
    mlabelColors(rowsToSetRed, 2) = 0;
    mlabelColors(rowsToSetRed, 3) = 0 ;

    mlabelColors(rowsToSetYellow, 1) = 1;
    mlabelColors(rowsToSetYellow, 2) = 1;
    mlabelColors(rowsToSetYellow, 3) = 0;

    mlabelColors(rowsToSetMagenta, 1) = 1;
    mlabelColors(rowsToSetMagenta, 2) = 0;
    mlabelColors(rowsToSetMagenta, 3) = 1;

    mlabelColors(rowsToSetGreen, 1) = 0;
    mlabelColors(rowsToSetGreen, 2) = 1;
    mlabelColors(rowsToSetGreen, 3) = 0;

    mlabelColors(rowsToSetCyan, 1) = 0.4;
    mlabelColors(rowsToSetCyan, 2) = 0.4;
    mlabelColors(rowsToSetCyan, 3) = 0.6;

    mlabelColors(rowsToSetBlack, 1) = 0;
    mlabelColors(rowsToSetBlack, 2) = 0;
    mlabelColors(rowsToSetBlack, 3) = 0;

    scatter(finalCentroids(:,1) , finalCentroids(:,2) , 100 , mlabelColors , 'd' , 'filled');
    hold on;
    
%% Visualisasi Result

    rowsToSetBlue = result2(:,3) == 1;
    rowsToSetRed = result2(:,3) == 2;
    rowsToSetYellow = result2(:,3) == 3;
    rowsToSetMagenta = result2(:,3) == 4;
    rowsToSetGreen = result2(:,3) == 5;
    rowsToSetCyan = result2(:,3) == 6;
    rowsToSetBlack = result2(:,3) == 7;

    myColors(rowsToSetBlue, 1) = 0;
    myColors(rowsToSetBlue, 2) = 0;
    myColors(rowsToSetBlue, 3) = 1;

    myColors(rowsToSetRed, 1) = 1;
    myColors(rowsToSetRed, 2) = 0;
    myColors(rowsToSetRed, 3) = 0 ;

    myColors(rowsToSetYellow, 1) = 1;
    myColors(rowsToSetYellow, 2) = 1;
    myColors(rowsToSetYellow, 3) = 0;

    myColors(rowsToSetMagenta, 1) = 1;
    myColors(rowsToSetMagenta, 2) = 0;
    myColors(rowsToSetMagenta, 3) = 1;

    myColors(rowsToSetGreen, 1) = 0;
    myColors(rowsToSetGreen, 2) = 1;
    myColors(rowsToSetGreen, 3) = 0;

    myColors(rowsToSetCyan, 1) = 0;
    myColors(rowsToSetCyan, 2) = 1;
    myColors(rowsToSetCyan, 3) = 1;

    myColors(rowsToSetBlack, 1) = 0;
    myColors(rowsToSetBlack, 2) = 0;
    myColors(rowsToSetBlack, 3) = 0;

    scatter(result2(:,1), result2(:,2) , 20 , myColors);
    