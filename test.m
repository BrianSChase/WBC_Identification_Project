image = imread('_0_260.jpeg');

[cell, ci, cj] = segment_cell(image);

%cell = rgb2gray(cell);

%n = segment_nucleus(cell);
cell = rgb2gray(cell);
cell = canny(double(cell),4);
%cell = edge(cell, 'sobel');
imshow(cell);
