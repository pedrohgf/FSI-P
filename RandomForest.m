dataset = csvread('\dataset\leaf.csv');
% dataset = dataset(randperm(size(dataset,1)),:);
Labels = dataset(:,1);
Features = dataset(:,3:end);
NumberOfPartitions = 10;
Partitions = cvpartition(1:length(dataset), 'KFold', NumberOfPartitions);

for i=1:NumberOfPartitions
    TSIndex = training(Partitions, i);
    TrainingSetLabels = Labels(TSIndex);
    TrainingSet = Features(TSIndex,:);
    TestIndex = test(Partitions, i);
    TestsetLabels = Labels(TestIndex);
    Testset = Features(TestIndex,:);
    Model = TreeBagger(50, TrainingSet, TrainingSetLabels);
    LabelsPredicted = predict(Model, Testset);
    keyboard;
end

% TestRatio = 0.1;
% OffsetRatio = 0;
% NumberOfSamples = length(dataset);
% TestsetIndex = OffsetRatio+1:OffsetRatio+1+TestRatio*NumberOfSamples;
% Testset = Features(TestsetIndex,:);
% TestsetLabels = Labels(TestsetIndex);
% TrainingSetIndex = setdiff(1:NumberOfSamples, TestsetIndex);
% TrainingSet = Features(TrainingSetIndex, :);
% TrainingSetLabels = Labels(TrainingSetIndex);

Model = TreeBagger(50, TrainingSet, TrainingSetLabels);
LabelsPredicted = predict(Model, Testset); 
% Model = TreeBagger(50, 