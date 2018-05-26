clear all
close all
clc

T = [];
Y = [];

for k = 1:300
    FILE = ['/Users/osman/Documents/GitHub/Character-Recognition-with-SoftMargin-SVM/Classifier/DATA/O/O-',num2str(k),'.png'];
    [x] = imread(FILE);
    [x]=imbinarize(x);
    FV = feature_extractor([x]);
    T = [T FV];
    Y = [Y; +1 +1];
end

for k = 1:300
    FILE = ['/Users/osman/Documents/GitHub/Character-Recognition-with-SoftMargin-SVM/Classifier/DATA/Z/Z-',num2str(k),'.png'];
    [x] = imread(FILE);
    [x]=imbinarize(x);
    FV = feature_extractor([x]);
    T = [T FV];
    Y = [Y; +1 -1];
end

for k = 1:300
    FILE = ['/Users/osman/Documents/GitHub/Character-Recognition-with-SoftMargin-SVM/Classifier/DATA/H/H-',num2str(k),'.png'];
    [x] = imread(FILE);
    [x]=imbinarize(x);
    FV = feature_extractor([x]);
    T = [T FV];
    Y = [Y; -1 +1];
end

for k = 1:300
    FILE = ['/Users/osman/Documents/GitHub/Character-Recognition-with-SoftMargin-SVM/Classifier/DATA/X/X-',num2str(k),'.png'];
    [x] = imread(FILE);
    [x]=imbinarize(x);
    FV = feature_extractor([x]);
    T = [T FV];
    Y = [Y; -1 -1];
end

MinT = min(T);
MaxT = max(T);

%Normalization
% for i =1:size(T,2)
%     T(:,i) = [T(:,i) - MinT(i)] / [MaxT(i) - MinT(i)];
% end

save imgData.mat T Y MinT MaxT