function result = central_moment(shape, i, j, center_i, center_j)

%% Calculate moment on subwindow with cell to speed up testing
%120 x 160
%cell = imread('_0_260.jpeg');
%[shape, center_i,center_j] = segment_cell(cell);
[rows, cols] = size(shape);
top = center_i - 60;
bottom = center_i + 60;
left = center_j - 80;
right = center_j + 80;

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

window = shape((top:bottom), (left:right));

%% Get M00, M10, M01 to get the averages of x and y to be used in central
%binarize
window = (window > 0);

%Get Area (M00)
[r,c] = size(window);
M00 = 0;
i0 = 0;
j0 = 0;
for x = 1:r
for y = 1:c
M00 = M00 + x^i0 * y^j0 * window(x, y);
end
end


%Get M10
M10 = 0;
i10 = 1;
j10 = 0;
for x = 1:r
for y = 1:c
M10 = M10 + x^i10 * y^j10 * window(x, y);
end
end
avgx = M10/M00;


%Get M01
M01 = 0;
i01 = 0;
j01 = 1;
for x = 1:r
for y = 1:c
M01 = M01 + x^i01 * y^j01 * window(x, y);
end
end
avgy = M01/M00;

%% Central Moment
CM = 0;
for x = 1:r
for y = 1:c
CM = CM + (x - avgx)^i * (y - avgy)^j * window(x, y);
end
end

result = CM;
