clear all;
close all;
clc

dataset = csvread('leaf.csv');
% dataset = dataset(randperm(size(dataset,1)),:);
Labels = dataset(:,1);
Features = dataset(:,3:end);

%simple leaves: classes 1:15 and 22:36

simpleLabels = [];
simpleFeatures = [];

for i=1:15
    idx = Labels == i;
    simpleLabels = [simpleLabels ; Labels(idx)];
    simpleFeatures = [simpleFeatures ; Features(idx)];
    Labels(idx) = [];
    Features(idx,:) = [];
end

for i=22:36
    idx = Labels == i;
    simpleLabels = [simpleLabels ; Labels(idx)];
    simpleFeatures = [simpleFeatures ; Features(idx)];
    Labels(idx) = [];
    Features(idx,:) = [];
end

complexFeatures = Features;
complexLabels = Labels;

clear i idx;
