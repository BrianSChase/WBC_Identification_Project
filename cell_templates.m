%Create a template for each cell type

%% Important Notes
%{
For the templates, only keeping values > 160 from the average scores
seems isolate the nucleus (it is black and cytoplasm is white).
%}

%% Get images
%240x320
%Neut
cd('C:\Users\Brian\Desktop\Current_Semester\Computer_Vision\Final_Project\100_Neutrophils');
imagefiles = dir('*.jpeg');
for i=1:100
   currentfilename = imagefiles(i).name;
   currentimage = imread(currentfilename);
   train_images_N{i} = currentimage;
end

%Lymph
cd('C:\Users\Brian\Desktop\Current_Semester\Computer_Vision\Final_Project\100_Lymphs');
imagefiles = dir('*.jpeg');
for i=1:100
   currentfilename = imagefiles(i).name;
   currentimage = imread(currentfilename);
   train_images_L{i} = currentimage;
end

%Mono
cd('C:\Users\Brian\Desktop\Current_Semester\Computer_Vision\Final_Project\100_Monos');
imagefiles = dir('*.jpeg');
for i=1:100
   currentfilename = imagefiles(i).name;
   currentimage = imread(currentfilename);
   train_images_M{i} = currentimage;
end

cd('C:\Users\Brian\Desktop\Current_Semester\Computer_Vision\Final_Project');

%% Get averages
averageN = (zeros(120, 160));
countN = 0;
averageL = zeros(120, 160);
countL = 0;
averageM = zeros(120,160);
countM = 0;

%temp_window = uint8(zeros(120,160));
temp_window = zeros(120,160);
for i = 1:1
    %120x160 window creation
    [cell, ci, cj]= segment_cell(train_images_N{i});
 

    
    [rows, cols] = size(cell);
    top = ci - 60;
    bottom = ci + 59;
    left = cj - 80;
    right = cj + 79;

    if(left < 1)
       left = 1;
    end
    if(right > cols)
      right = cols;
    end
    if(top < 1)
      top = 1;
    end
    if(bottom > rows)
     bottom  = rows;
    end
      window = cell((top:bottom), (left:right)); 

      %Current idea to deal with matrix sizes
      [r,c] = size(window);
      for x = 1:r
          for y = 1:c
              temp_window(x,y) = window(x,y);
          end
      end
      
      
      averageN = averageN(:,:) + double(temp_window(:,:));
      countN = countN + 1;
end

averageN = (averageN / countN);

  
    
for i = 1:1
    %120x160 window creation
    [cell, ci, cj]= segment_cell(train_images_L{i});
 

    
    [rows, cols] = size(cell);
    top = ci - 60;
    bottom = ci + 59;
    left = cj - 80;
    right = cj + 79;

    if(left < 1)
       left = 1;
    end
    if(right > cols)
      right = cols;
    end
    if(top < 1)
      top = 1;
    end
    if(bottom > rows)
     bottom  = rows;
    end
      window = cell((top:bottom), (left:right)); 

      %Current idea to deal with matrix sizes
      [r,c] = size(window);
      for x = 1:r
          for y = 1:c
              temp_window(x,y) = window(x,y);
          end
      end
      
    
      averageL = averageL(:,:) + double(temp_window(:,:));
      countL = countL + 1;
end

averageL = (averageL / countL);


for i = 1:1
    %120x160 window creation
    [cell, ci, cj]= segment_cell(train_images_M{i});
  

    
    [rows, cols] = size(cell);
    top = ci - 60;
    bottom = ci + 59;
    left = cj - 80;
    right = cj + 79;

    if(left < 1)
       left = 1;
    end
    if(right > cols)
      right = cols;
    end
    if(top < 1)
      top = 1;
    end
    if(bottom > rows)
     bottom  = rows;
    end
      window = cell((top:bottom), (left:right)); 

      %Current idea to deal with matrix sizes
      [r,c] = size(window);
      for x = 1:r
          for y = 1:c
              temp_window(x,y) = window(x,y);
          end
      end
      
    
      averageM = averageM(:,:) + double(temp_window(:,:));
      countM = countM + 1;
end

averageM = (averageM / countM);
%{
%imshow(averageM > 160);
averageN = (averageN > 160);
averageL = (averageL > 160);
averageM = (averageM > 160);

averageN = averageN';
averageL = averageL';
averageM = averageM';
figure(1); imshow(averageN);
figure(2); imshow(averageL);
figure(3); imshow(averageM);
%}

averageN = (averageN > 10);
averageL = (averageL > 10);
averageM = (averageM > 10);
%% Testing normalized correlation

normcor_result = zeros(10, 1);
for i = 1:10
    [cell, ci, cj]= segment_cell(train_images_M{i});
    test_N = rgb2gray(cell);

    
    test_N = (test_N > 0);
    imshow(test_N);
    normcor_result(i,1) = recognize_digit(test_N, averageM,averageN);
end
%figure(4); imshow(test_N);
count2 = 0;
count3 = 0;
for i = 1:10
    if(normcor_result(i,1) == 2)
        count2 = count2 + 1;
    end
    if(normcor_result(i,1) == 3)
        count3 = count3 + 1;
    end    
end

