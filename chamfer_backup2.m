cd('C:\Users\Brian\Desktop\Current_Semester\Computer_Vision\Final_Project\100_Neutrophils');
imagefiles = dir('*.jpeg');
for i=1:100
   currentfilename = imagefiles(i).name;
   currentimage = imread(currentfilename);
   train_images_N{i} = currentimage;
end


cd('C:\Users\Brian\Desktop\Current_Semester\Computer_Vision\Final_Project\100_Lymphs');
imagefiles = dir('*.jpeg');
for i=1:100
   currentfilename = imagefiles(i).name;
   currentimage = imread(currentfilename);
   train_images_L{i} = currentimage;
end

cd('C:\Users\Brian\Desktop\Current_Semester\Computer_Vision\Final_Project\100_Monos');
imagefiles = dir('*.jpeg');
for i=1:100
   currentfilename = imagefiles(i).name;
   currentimage = imread(currentfilename);
   train_images_M{i} = currentimage;
end

cd('C:\Users\Brian\Desktop\Current_Semester\Computer_Vision\Final_Project\100_Eos');
imagefiles = dir('*.jpeg');
for i=1:100
   currentfilename = imagefiles(i).name;
   currentimage = imread(currentfilename);
   train_images_E{i} = currentimage;
end


cd('C:\Users\Brian\Desktop\Current_Semester\Computer_Vision\Final_Project');

%% Create templates
%Neutrophils
for i = 1:100
   image = train_images_N{i};
   [cell, ci, cj] = segment_cell(image);
   cell = center_cell(cell, ci, cj);
   cell = canny(double(cell),7);
   templates_N{i} = cell;
end

%Monos
for i = 1:100
   image = train_images_M{i};
   [cell, ci, cj] = segment_cell(image);
   cell = center_cell(cell, ci, cj);
   cell = canny(double(cell),7);
   templates_M{i} = cell;
end

%lymphs
for i = 1:100
   image = train_images_L{i};
   [cell, ci, cj] = segment_cell(image);
   cell = center_cell(cell, ci, cj);
   cell = canny(double(cell),7);
   templates_L{i} = cell;
end


%% Testing


cd('C:\Users\Brian\Desktop\Current_Semester\Computer_Vision\Final_Project\Neutrophil_test')
imagefiles = dir('*.jpeg');
for i=1:500
   currentfilename = imagefiles(i).name;
   currentimage = imread(currentfilename);
   test_images_N{i} = currentimage;
end


cd('C:\Users\Brian\Desktop\Current_Semester\Computer_Vision\Final_Project\Lymphocyte_test')
imagefiles = dir('*.jpeg');
for i=1:500
   currentfilename = imagefiles(i).name;
   currentimage = imread(currentfilename);
   test_images_L{i} = currentimage;
end

cd('C:\Users\Brian\Desktop\Current_Semester\Computer_Vision\Final_Project\Monocyte_test')
imagefiles = dir('*.jpeg');
for i=1:500
   currentfilename = imagefiles(i).name;
   currentimage = imread(currentfilename);
   test_images_M{i} = currentimage;
end


cd('C:\Users\Brian\Desktop\Current_Semester\Computer_Vision\Final_Project');
for i = 1:500
   image = test_images_N{i};
   [cell, ci, cj] = segment_cell(image);
   cell = center_cell(cell, ci, cj);
   cell = canny(double(cell),7);
   test_N{i} = cell;
end

for i = 1:500
   image = test_images_L{i};
   [cell, ci, cj] = segment_cell(image);
   cell = center_cell(cell, ci, cj);
   cell = canny(double(cell),7);
   test_L{i} = cell;
end

for i = 1:500
   image = test_images_M{i};
   [cell, ci, cj] = segment_cell(image);
   cell = center_cell(cell, ci, cj);
   cell = canny(double(cell),7);
   test_M{i} = cell;
end




%% Chamfer part 

distances_N = zeros(500,50);
distances_L = zeros(500,50);
distances_M = zeros(500,50);


% Main Loop
for i = 1:500
    e1 = bwdist(test_N{i});
    e2 = bwdist(test_L{i});
    e3 = bwdist(test_M{i});
    
    for j = 1:50
        
   t1 = templates_N{j};
   t2 = templates_L{j};
   t3 = templates_M{j}; 
   
   distances_N(i,j) = sum(sum(t1 .* e1));
   distances_L(i,j) = sum(sum(t2 .* e1));
   distances_M(i,j) = sum(sum(t3 .* e1));

   
    end
end

distances_N = distances_N';
distances_L = distances_L';
distances_M = distances_M';


N = min(distances_N);
L = min(distances_L);
M = min(distances_M);


all_distances = zeros(500,3);
for i = 1:500
    all_distances(i,1) = N(1,i);
    all_distances(i,2) = L(1,i);
    all_distances(i,3) = M(1,i);
end

all_distances = all_distances';
[val,I] = min(all_distances);
    
   
N_count = 0;
L_count = 0;
M_count = 0;


for i = 1:500
    if(I(i) == 1)
        N_count = N_count + 1;
    end

    if(I(i) == 2)
        L_count = L_count + 1;
    end    

    if(I(i) == 3)
        M_count = M_count + 1;
    end   
    
end

         
