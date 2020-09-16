%{
Test nearest neighbor on central moments
%}

%% Get test images
%Test Neut images
cd('C:\Users\Brian\Desktop\Current_Semester\Computer_Vision\dataset2-master\images\TEST\NEUTROPHIL');
imagefiles = dir('*.jpeg');
for i=1:100
   currentfilename = imagefiles(i).name;
   currentimage = imread(currentfilename);
   test_images_N{i} = currentimage;
end

%Test Lymph images
cd('C:\Users\Brian\Desktop\Current_Semester\Computer_Vision\dataset2-master\images\TEST\LYMPHOCYTE');
imagefiles = dir('*.jpeg');
for i=1:100
   currentfilename = imagefiles(i).name;
   currentimage = imread(currentfilename);
   test_images_L{i} = currentimage;
end

%Test Mono images
cd('C:\Users\Brian\Desktop\Current_Semester\Computer_Vision\dataset2-master\images\TEST\MONOCYTE');
imagefiles = dir('*.jpeg');
for i=1:100
   currentfilename = imagefiles(i).name;
   currentimage = imread(currentfilename);
   test_images_M{i} = currentimage;
end
%{
%Test Eos images
cd('C:\Users\Brian\Desktop\Current_Semester\Computer_Vision\dataset2-master\images\TEST\EOSINOPHIL');
imagefiles = dir('*.jpeg');
for i=1:100
   currentfilename = imagefiles(i).name;
   currentimage = imread(currentfilename);
   test_images_E{i} = currentimage;
end
%}

cd('C:\Users\Brian\Desktop\Current_Semester\Computer_Vision\Final_Project');

%% Get central moments
%{
In here for now I'm going to test sets of 100 of each type of cell and
see the percentage of how many get correctly classified.
%}

%Get test moments Neut
test_moments_N_cm = zeros(100,4);
for i = 1:100
    [input, ci, cj]= segment_cell(test_images_N{i});
    input = (input > 0);
    
    test_moments_N_cm(i,1) = central_moment(input, 0, 0,ci,cj);
    test_moments_N_cm(i,2) = central_moment(input, 1, 0,ci,cj);
    test_moments_N_cm(i,3) = central_moment(input, 3, 0,ci,cj);
   % test_moments_N_cm(i,4) = central_moment(input, 1, 2,ci,cj);
end

%Get training moments Lymphs
test_moments_L_cm = zeros(100,4);
for i = 1:100
    [input, ci, cj]= segment_cell(test_images_L{i});
    input = (input > 0);
    
    test_moments_L_cm(i,1) = central_moment(input, 0, 0,ci,cj);
    test_moments_L_cm(i,2) = central_moment(input, 1, 0,ci,cj);
    test_moments_L_cm(i,3) = central_moment(input, 3, 0,ci,cj);
   % test_moments_L_cm(i,4) = central_moment(input, 1, 2,ci,cj);
end

%Get training moments Monos
test_moments_M_cm = zeros(100,4);
for i = 1:100
    [input, ci, cj]= segment_cell(test_images_M{i});
    input = (input > 0);
    
    test_moments_M_cm(i,1) = central_moment(input, 0, 0,ci,cj);
    test_moments_M_cm(i,2) = central_moment(input, 1, 0,ci,cj);
    test_moments_M_cm(i,3) = central_moment(input, 3, 0,ci,cj);
   % test_moments_M_cm(i,4) = central_moment(input, 1, 2,ci,cj);
end
%{
%Get training moments Eos
test_moments_E_cm = zeros(100,4);
for i = 1:100
    [input, ci, cj]= segment_cell(test_images_E{i});
    input = (input > 0);
    
    test_moments_E_cm(i,1) = central_moment(input, 0, 0,ci,cj);
    test_moments_E_cm(i,2) = central_moment(input, 1, 0,ci,cj);
    test_moments_E_cm(i,3) = central_moment(input, 3, 0,ci,cj);
   % test_moments_E_cm(i,4) = central_moment(input, 1, 2,ci,cj);
end
%}
%% Calculate distances
load('CM_training.mat', 'train_moments_N_cm','train_moments_L_cm','train_moments_M_cm');

dist_N = zeros(100,3);
dist_L = zeros(100,3);
dist_M = zeros(100,3);
dist_E = zeros(100,3);
for i = 1:100
    for j = 1:4
        dist_N(i,j) = sqrt(sum(sum((test_moments_N_cm(i,j) - train_moments_N_cm(i,j))^2)));
        dist_L(i,j) = sqrt(sum(sum((test_moments_N_cm(i,j) - train_moments_L_cm(i,j))^2)));
        dist_M(i,j) = sqrt(sum(sum((test_moments_N_cm(i,j) - train_moments_M_cm(i,j))^2)));
     %   dist_E(i,j) = sqrt(sum(sum((test_moments_M_cm(i,j) - train_moments_E_cm(i,j))^2)));
        
    end
end

sum_dist_N = sum(dist_N, 2);
sum_dist_L = sum(dist_L, 2);
sum_dist_M = sum(dist_M, 2);
%sum_dist_E = sum(dist_E, 2);

Neut = 0;
Lymph = 0;
Mono = 0;
%Eos = 0;

cell = 0;
for i = 1:100
    best_dist = 1000000000000000000;
    if(sum_dist_N(i,1) < best_dist)
        best_dist = sum_dist_N(i,1);
        cell = 1;
    end
    if(sum_dist_L(i,1) < best_dist)
        best_dist = sum_dist_L(i,1);
        cell = 2;
    end    
    if(sum_dist_M(i,1) < best_dist)
        best_dist = sum_dist_M(i,1);
        cell = 3;
    end    
    %{
    if(sum_dist_E(i,1) < best_dist)
        best_dist = sum_dist_E(i,1);
        cell = 4;
    end
    %}
    if(cell == 1)
        Neut = Neut + 1;
    end
    if(cell == 2)
        Lymph = Lymph + 1;
    end   
    if(cell == 3)
        Mono = Mono + 1;
    end
    %{
    if(cell == 4)
        Eos = Eos + 1;
    end    
    %}
end
