function result = recognize_digit(image, average2, average3)



%photo = read_gray(image);
photo = image;
result1 = normxcorr2(average2, photo);

result1 = normalized_correlation(photo, average2);

val1 = abs(sum(result1, 'all'));

result2 = normxcorr2(average3, photo);
result2 = normalized_correlation(photo, average3);


val2 = abs(sum(result2, 'all'));

if(val1 > val2)
    result = 2;
else
    result = 3;
end
end
