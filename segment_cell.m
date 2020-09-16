function [result,center_i,center_j] = segment_cell(input)



%% Find blue to segment cells

r = input(:,:,1);
g = input(:,:,2);
b = input(:,:,3);




blue = ((b - r > 10) & (b - g > 10));

blue = imdilate(blue, ones(9,9));
%figure(2); imshow(blue);

%Set all non-blue pixels in input image to zero
blue_only = input;
for i = 1:240
    for j = 1:320
        if(blue(i,j) == 0)
            blue_only(i,j,1) = 0;
            blue_only(i,j,2) = 0;
            blue_only(i,j,3) = 0;
        end
    end
end
%figure(3); imshow(blue_only);


%%%%%%%%%%%%%%%%
%Red test seg/eos
%%%%%%%%%%%%%%%%
r2 = blue_only(:,:,1);
g2 = blue_only(:,:,2);
b2 = blue_only(:,:,3);

total_r2 = sum(sum(r2));
%Initial testing, total r2 higher in eos than neut, try more input and
%then consider using this as a differentiation criteria.

%%%%%%%%%%%%%%%%%%


%% Further segemnt to get rid of platelets that dilate/erode/dilate does
%not get rid of
[labels, number] = bwlabel(blue, 4);
counters = zeros(1, number);
for i = 1:number
    component_image = (labels == i);
    
    counters(i) = sum(component_image(:));
end

[area, id] = max(counters);
largest_component = (labels == id);

%set all but the largest component to zero
for i = 1:240
    for j = 1:320
        if(largest_component(i,j) ~= 1)
            blue_only(i,j,1) = 0;
            blue_only(i,j,2) = 0;
            blue_only(i,j,3) = 0;
        end
    end
end
%figure(4); imshow(blue_only);

%% segment nucleus

nucleus = segment_nucleus(input);
for i = 1:240
    for j = 1:320
        if(nucleus(i,j) == 0)
            blue_only(i,j,1) = 0;
            blue_only(i,j,2) = 0;
            blue_only(i,j,3) = 0;
        end
    end
end

%% Get center of cell
[rows, cols] = find(largest_component);
center_i = round(mean(rows));
center_j = round(mean(cols));

%returns nucleus only
result = blue_only;