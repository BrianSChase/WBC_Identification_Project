
moment = zeros(10,6);

counter = zeros(1,10);
load_mnist;

for i = 1:5000
    if(mnist_labels(i) == 0)
        input = mnist_digits(:,:,i);
  
        input = (input > 0);
        moment(1,1) = moment(1,1) + central_moment(input,0,0);
        moment(1,2) = moment(1,2) + central_moment(input,1,0);
        moment(1,3) = moment(1,3) + central_moment(input,0,1);
        moment(1,4) = moment(1,4) + central_moment(input,1,1);
        moment(1,5) = moment(1,5) + central_moment(input,1,2); 
        moment(1,6) = moment(1,6) + central_moment(input,2,1);
        counter(1,1) = counter(1,1) + 1;
    end
    if(mnist_labels(i) == 1)
        input = mnist_digits(:,:,i);

        input = (input > 0);
        moment(2,1) = moment(2,1) + central_moment(input,0,0);
        moment(2,2) = moment(2,2) + central_moment(input,1,0);
        moment(2,3) = moment(2,3) + central_moment(input,0,1);
        moment(2,4) = moment(2,4) + central_moment(input,1,1);
        moment(2,5) = moment(2,5) + central_moment(input,1,2);
        moment(2,6) = moment(2,6) + central_moment(input,2,1);
        counter(1,2) = counter(1,2) + 1;
    end    
    if(mnist_labels(i) == 2)
        input = mnist_digits(:,:,i);
    
        input = (input > 0);
        moment(3,1) = moment(3,1) + central_moment(input,0,0);
        moment(3,2) = moment(3,2) + central_moment(input,1,0);
        moment(3,3) = moment(3,3) + central_moment(input,0,1);
        moment(3,4) = moment(3,4) + central_moment(input,1,1);
        moment(3,5) = moment(3,5) + central_moment(input,1,2);
        moment(3,6) = moment(3,6) + central_moment(input,2,1);
        counter(1,3) = counter(1,3) + 1;
    end     
    if(mnist_labels(i) == 3)
        input = mnist_digits(:,:,i);
 
        input = (input > 0);
        moment(4,1) = moment(4,1) + central_moment(input,0,0);
        moment(4,2) = moment(4,2) + central_moment(input,1,0);
        moment(4,3) = moment(4,3) + central_moment(input,0,1);
        moment(4,4) = moment(4,4) + central_moment(input,1,1);
        moment(4,5) = moment(4,5) + central_moment(input,1,2);
        moment(4,6) = moment(4,6) + central_moment(input,2,1);
        counter(1,4) = counter(1,4) + 1;
    end  
    if(mnist_labels(i) == 4)
        input = mnist_digits(:,:,i);

        input = (input > 0);
        moment(5,1) = moment(5,1) + central_moment(input,0,0);
        moment(5,2) = moment(5,2) + central_moment(input,1,0);
        moment(5,3) = moment(5,3) + central_moment(input,0,1);
        moment(5,4) = moment(5,4) + central_moment(input,1,1);
        moment(5,5) = moment(5,5) + central_moment(input,1,2);
        moment(5,6) = moment(5,6) + central_moment(input,2,1);
        counter(1,5) = counter(1,5) + 1;
    end          
    if(mnist_labels(i) == 5)
        input = mnist_digits(:,:,i);

        input = (input > 0);
        moment(6,1) = moment(6,1) + central_moment(input,0,0);
        moment(6,2) = moment(6,2) + central_moment(input,1,0);
        moment(6,3) = moment(6,3) + central_moment(input,0,1);
        moment(6,4) = moment(6,4) + central_moment(input,1,1);
        moment(6,5) = moment(6,5) + central_moment(input,1,2);
        moment(6,6) = moment(6,6) + central_moment(input,2,1);
        counter(1,6) = counter(1,6) + 1;
    end   
    
    if(mnist_labels(i) == 6)
        input = mnist_digits(:,:,i);
        input = (input > 0);
        moment(7,1) = moment(7,1) + central_moment(input,0,0);
        moment(7,2) = moment(7,2) + central_moment(input,1,0);
        moment(7,3) = moment(7,3) + central_moment(input,0,1);
        moment(7,4) = moment(7,4) + central_moment(input,1,1);
        moment(7,5) = moment(7,5) + central_moment(input,1,2);
        moment(7,6) = moment(7,6) + central_moment(input,2,1);
        counter(1,7) = counter(1,7) + 1;
    end      
    if(mnist_labels(i) == 7)
        input = mnist_digits(:,:,i);
        input = (input > 0);
        moment(8,1) = moment(8,1) + central_moment(input,0,0);
        moment(8,2) = moment(8,2) + central_moment(input,1,0);
        moment(8,3) = moment(8,3) + central_moment(input,0,1);
        moment(8,4) = moment(8,4) + central_moment(input,1,1);
        moment(8,5) = moment(8,5) + central_moment(input,1,2);
        moment(8,6) = moment(8,6) + central_moment(input,2,1);
        counter(1,8) = counter(1,8) + 1;
    end  
    if(mnist_labels(i) == 8)
        input = mnist_digits(:,:,i);
        input = (input > 0);
        moment(9,1) = moment(9,1) + central_moment(input,0,0);
        moment(9,2) = moment(9,2) + central_moment(input,1,0);
        moment(9,3) = moment(9,3) + central_moment(input,0,1);
        moment(9,4) = moment(9,4) + central_moment(input,1,1);
        moment(9,5) = moment(9,5) + central_moment(input,1,2);
        moment(9,6) = moment(9,6) + central_moment(input,2,1);
        counter(1,9) = counter(1,9) + 1;
    end  
    if(mnist_labels(i) == 9)
        input = mnist_digits(:,:,i);
        input = (input > 0);
        moment(10,1) = moment(10,1) + central_moment(input,0,0);
        moment(10,2) = moment(10,2) + central_moment(input,1,0);
        moment(10,3) = moment(10,3) + central_moment(input,0,1);
        moment(10,4) = moment(10,4) + central_moment(input,1,1);
        moment(10,5) = moment(10,5) + central_moment(input,1,2);
        moment(10,6) = moment(10,6) + central_moment(input,2,1);
        counter(1,10) = counter(1,10) + 1;
    end 
end
%% Get averages

for i = 1:10
    for j = 1:6
        moment(i,j) = (moment(i,j) / counter(1,i));
    end
end


%SAVE MOMENTS INTO A .MAT FILE
save('training_moments.mat','moment'); 