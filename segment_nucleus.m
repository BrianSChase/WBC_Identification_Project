function result = segment_nucleus(input)

%% This first part just uses a threshold, I think a skin detection type thing may
%be better

%{
%input will be grayscale image from segment_cell

[r,c] = size(input);
%{
for i = 1:r
    for j = 1:c
        if(input(i,j) == 0)
            input(i,j) = 255;
        end
    end
end
%}

for i = 1:r
    for j = 1:c
        if((input(i,j) < 110) && (input(i,j) > 0))
            input(i,j) = 1;
        end
        
        if(input(i,j) > 160)
            input(i,j) = 0;
        end
        
    end
end


    
imshow(input);

%input = watershed(input);

result = input;

%}

%% use "skin detection", get patches
sample1 = double(imread('_0_204.jpeg'));
sample2 = double(imread('_0_260.jpeg'));
sample3 = double(imread('_0_1986.jpeg'));
%sample1 = imread('_0_204.jpeg');
%sample2 = imread('_0_260.jpeg');
%sample3 = imread('_0_1986.jpeg');

patch1 = sample1(65:85, 200:220, :) / 255;
patch2 = sample2(180:200, 105:125, :) / 255;
patch3 = sample3(110:130, 205:225, :) / 255;

patch_average = (patch1 + patch2 + patch3) / 3;


%% Next step

%sample_red = patch3(:, :, 1);
%sample_green = patch3(:, :, 2);
%sample_blue = patch3(:, :, 3);
sample_red = patch_average(:, :, 1);
sample_green = patch_average(:, :, 2);
sample_blue = patch_average(:, :, 3);

sample_red = sample_red(:);
sample_green = sample_green(:);
sample_blue = sample_blue(:);

sample_total = sample_red + sample_green + sample_blue;
sample_red2 = sample_red ./ sample_total;
sample_red2(isnan(sample_red2)) = 0; % when (R+G+B) == 0, a division by 0 can result in a NaN
sample_green2 = sample_green ./ sample_total;
sample_green2(isnan(sample_green2)) = 0;



r_mean = mean(sample_red2);
g_mean = mean(sample_green2);
r_std = std(sample_red2);
g_std = std(sample_green2);

%% Test

%frame20 = double(imread('_0_4892.jpeg'));
frame20 = double(input);
[rows,cols, bands] = size(frame20);

skin_detection2 = zeros(rows, cols);

for row = 1:rows
    for col = 1:cols
        red = frame20(row, col, 1);
        green = frame20(row, col, 2);
        blue = frame20(row, col, 3);
    
        sum = red+green+blue;
        if sum > 0
            r = red / sum;
            g = green / sum;
        else
            r = 0;
            g = 0;
        end
        
        r_prob = gaussian_probability(r_mean, r_std, r);
        g_prob = gaussian_probability(g_mean, g_std, g);
        prob = r_prob * g_prob;
        skin_detection2(row, col) = prob;
    end
end

%skin_detection2 = imdilate(skin_detection2, ones(2,2));

%figure(4); imshow(skin_detection2 >10 , []);

skin_detection2 = (skin_detection2 > 10);



result = imdilate(skin_detection2, ones(4,4));

