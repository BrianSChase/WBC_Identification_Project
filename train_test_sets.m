
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


save('templates_and_test.mat', 'test_N', 'test_L', 'test_M', 'templates_N',...
    'templates_L', 'templates_M');