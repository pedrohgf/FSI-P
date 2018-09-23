dataset = csvread('\dataset\leaf.csv');
% dataset = dataset(randperm(size(dataset,1)),:);
Labels = dataset(:,1);
Features = dataset(:,3:end);
NumberOfPartitions = 10;
Partitions = cvpartition(1:length(dataset), 'KFold', NumberOfPartitions);
CorrectPrediction = 0;

TrueLabels = [];
GuessedLabels = [];
NumberOfDecisionTrees = 18;
    
for i=1:NumberOfPartitions
    TSIndex = training(Partitions, i);
    TrainingSetLabels = Labels(TSIndex);
    TrainingSet = Features(TSIndex,:);
    TestIndex = test(Partitions, i);
    TestsetLabels = Labels(TestIndex);
    Testset = Features(TestIndex,:);
    Model = TreeBagger(NumberOfDecisionTrees, TrainingSet, TrainingSetLabels);
    LabelsPredicted = predict(Model, Testset);
    LabelsPredicted = cellfun(@str2num, LabelsPredicted, 'UniformOutput', false);
    LabelsPredicted = cell2mat(LabelsPredicted);
    CorrectPrediction = CorrectPrediction + sum(LabelsPredicted == TestsetLabels);
    TrueLabels = [TrueLabels TestsetLabels'];
    GuessedLabels = [GuessedLabels LabelsPredicted'];
end

ClassRightPredicted = [];
ClassWrongPredicted = [];
NumberOfClasses = 40;
for i=1:NumberOfClasses
    IDX = find(TrueLabels == i);
    ClassRightPredicted(i) = sum(GuessedLabels(IDX) == i);
    ClassWrongPredicted(i) = length(IDX) - ClassRightPredicted(i);
end

CorrectPredictionRatio = ClassRightPredicted./(ClassRightPredicted+ClassWrongPredicted);