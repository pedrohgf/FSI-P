dataset = csvread('\dataset\leaf.csv');
Labels = dataset(:,1);
Features = dataset(:,3:end);

TestRatio = 0.1;
OffsetRatio = 0;
NumberOfSamples = length(dataset);
TestsetIndex = OffsetRatio+1:OffsetRatio+1+TestRatio*NumberOfSamples;
Testset = Features(TestsetIndex,:);
TrainingSetIndex = setdiff(1:NumberOfSamples, TestsetIndex);
TrainingSet = Features(TrainingSetIndex, :);
