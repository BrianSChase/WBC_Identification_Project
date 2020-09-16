%{
In this file I need to create training vectors for all the cell types.

DIRECTORIES:
C:\Users\Brian\Desktop\Current_Semester\Computer_Vision\dataset2-master...
\images\TRAIN\NEUTROPHIL

C:\Users\Brian\Desktop\Current_Semester\Computer_Vision\dataset2-master...
\images\TRAIN\LYMPHOCYTE

C:\Users\Brian\Desktop\Current_Semester\Computer_Vision\dataset2-master...
\images\TRAIN\MONOCYTE

 C:\Users\Brian\Desktop\Current_Semester\Computer_Vision\dataset2-master...
\images\TRAIN\EOSINOPHIL
%}



%% Get sets of images for training
     
%nfiles = length(imagefiles);    % Number of files found
cd('C:\Users\Brian\Desktop\Current_Semester\Computer_Vision\dataset2-master\images\TRAIN\NEUTROPHIL');
imagefiles = dir('*.jpeg');
for i=1:100
   currentfilename = imagefiles(i).name;
   currentimage = imread(currentfilename);
   train_images_N{i} = currentimage;
end


cd('C:\Users\Brian\Desktop\Current_Semester\Computer_Vision\dataset2-master\images\TRAIN\LYMPHOCYTE');
imagefiles = dir('*.jpeg');
for i=1:100
   currentfilename = imagefiles(i).name;
   currentimage = imread(currentfilename);
   train_images_L{i} = currentimage;
end

cd('C:\Users\Brian\Desktop\Current_Semester\Computer_Vision\dataset2-master\images\TRAIN\MONOCYTE');
imagefiles = dir('*.jpeg');
for i=1:100
   currentfilename = imagefiles(i).name;
   currentimage = imread(currentfilename);
   train_images_M{i} = currentimage;
end
%{
cd('C:\Users\Brian\Desktop\Current_Semester\Computer_Vision\dataset2-master\images\TRAIN\EOSINOPHIL');
imagefiles = dir('*.jpeg');
for i=1:100
   currentfilename = imagefiles(i).name;
   currentimage = imread(currentfilename);
   train_images_E{i} = currentimage;
end

%}




%% Get training moments
cd('C:\Users\Brian\Desktop\Current_Semester\Computer_Vision\Final_Project');


%Get training moments Neut
train_moments_N_cm = zeros(100,4);
for i = 1:100
    [input, ci, cj]= segment_cell(train_images_N{i});
    
    
    train_moments_N_cm(i,1) = central_moment(input, 0, 0,ci,cj);
    train_moments_N_cm(i,2) = central_moment(input, 1, 0,ci,cj);
    train_moments_N_cm(i,3) = central_moment(input, 3, 0,ci,cj);
   % train_moments_N_cm(i,4) = central_moment(input, 1, 2,ci,cj);    
end

%Get training moments Lymphs
train_moments_L_cm = zeros(100,4);
for i = 1:100
    [input, ci, cj]= segment_cell(train_images_L{i});
    input = (input > 0);
    
    train_moments_L_cm(i,1) = central_moment(input, 0, 0,ci,cj);
    train_moments_L_cm(i,2) = central_moment(input, 1, 0,ci,cj);
    train_moments_L_cm(i,3) = central_moment(input, 3, 0,ci,cj);
   % train_moments_L_cm(i,4) = central_moment(input, 1, 2,ci,cj);
end

%Get training moments Monos
train_moments_M_cm = zeros(100,4);
for i = 1:100
    [input, ci, cj]= segment_cell(train_images_M{i});
    input = (input > 0);
    
    train_moments_M_cm(i,1) = central_moment(input, 0, 0,ci,cj);
    train_moments_M_cm(i,2) = central_moment(input, 1, 0,ci,cj);
    train_moments_M_cm(i,3) = central_moment(input, 3, 0,ci,cj);
   % train_moments_M_cm(i,4) = central_moment(input, 1, 2,ci,cj);
end
%{
%Get training moments Eos
train_moments_E_cm = zeros(100,4);
for i = 1:100
    [input, ci, cj]= segment_cell(train_images_E{i});
    input = (input > 0);
    
    train_moments_E_cm(i,1) = central_moment(input, 0, 0,ci,cj);
    train_moments_E_cm(i,2) = central_moment(input, 1, 0,ci,cj);
    train_moments_E_cm(i,3) = central_moment(input, 3, 0,ci,cj);
    %train_moments_E_cm(i,4) = central_moment(input, 1, 2,ci,cj);
end
%}
save('CM_training.mat', 'train_moments_N_cm','train_moments_L_cm','train_moments_M_cm');


