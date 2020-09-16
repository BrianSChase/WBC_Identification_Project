function result = classify_digit_cm(digit)
%load_mnist;
%digit = mnist_digits(:,:,437);
digit = (digit > 0);



%% Moments from input image (digit)
digit_moments = zeros(1,8);
digit_moments(1,1) = central_moment(digit, 0, 0);
digit_moments(1,2) = central_moment(digit, 1, 0);
digit_moments(1,3) = central_moment(digit, 0, 1);
digit_moments(1,4) = central_moment(digit, 1, 1);
digit_moments(1,5) = central_moment(digit, 1, 2);
digit_moments(1,6) = central_moment(digit, 2, 1);
digit_moments(1,7) = central_moment(digit, 2, 2);
digit_moments(1,8) = central_moment(digit, 3, 0);


%% Calculate distances
dist = zeros(5000,8);
load('training_moments.mat','moment','labels');

for i = 1:5000
    for j = 1:8
        dist(i,j) = sqrt(sum(sum((digit_moments(1,j) - moment(i,j))^2)));
    end
end

%% Find shortest distance
sum_dist = sum(dist, 2);     
        
[x,digit_id] = min(sum_dist);

result = labels(1,digit_id);

