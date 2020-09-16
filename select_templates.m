clear all;



load('templates_and_test.mat', 'test_N', 'test_L', 'test_M', 'templates_N',...
    'templates_L', 'templates_M');

%{
%% Get distances from neutrophil to lymph
distances = zeros(100,100);



% Main Loop
for i = 1:500
    e1 = bwdist(test_N{i});

    for j = 1:100
        
   t1 = templates_L{j};

   
   distances(i,j) = sum(sum(t1 .* e1));
   
    end
end


%% Select Lymphs

averages = mean(distances);

averages2 = mean(averages);
counter = 1;
for i = 1:100
    if(averages(i) > averages2)
        best_t_L{counter} = averages(i);
        counter = counter + 1;
    end
end


%% Select Monos from Neuts

distances = zeros(100,100);
for i = 1:500
    e1 = bwdist(test_N{i});

    for j = 1:100
        
   t1 = templates_M{j};

   
   distances(i,j) = sum(sum(t1 .* e1));
   
    end
end

averages = mean(distances);

averages2 = mean(averages);
counter = 1;
for i = 1:100
    if(averages(i) > averages2)
        best_t_M{counter} = averages(i);
        counter = counter + 1;
    end
end
%}
    
%% Neut templats most similar to Neut
distances = zeros(100,100);

for i = 1:500
    e1 = bwdist(test_N{i});

    for j = 1:100
        
   t1 = templates_N{j};

   
   distances(i,j) = sum(sum(t1 .* e1));
   
    end
end


averages = mean(distances);

averages2 = mean(averages);
counter = 1;
for i = 1:100
    if(averages(i) < (averages2 + 1000))
        best_t_N{counter} = averages(i);
        counter = counter + 1;
    end
end
    
  



%% Lymph templats most similar to Lymph
distances = zeros(100,100);

for i = 1:500
    e1 = bwdist(test_L{i});

    for j = 1:100
        
   t1 = templates_L{j};

   
   distances(i,j) = sum(sum(t1 .* e1));
   
    end
end


averages = mean(distances);

averages2 = mean(averages);
counter = 1;
for i = 1:100
    if(averages(i) < (averages2 + 1000))
        best_t_L{counter} = averages(i);
        counter = counter + 1;
    end
end

%% Most similar Mono template to monos
distances = zeros(100,100);

for i = 1:500
    e1 = bwdist(test_M{i});

    for j = 1:100
        
   t1 = templates_M{j};

   
   distances(i,j) = sum(sum(t1 .* e1));
   
    end
end


averages = mean(distances);

averages2 = mean(averages);
counter = 1;
for i = 1:100
    if(averages(i) < (averages2 + 1000))
        best_t_M{counter} = averages(i);
        counter = counter + 1;
    end
end   
%% Save templates
save('chosen_templates.mat', 'best_t_L', 'best_t_M', 'best_t_N'); 