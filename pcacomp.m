clc
clear all
format long

K1 = 5;
K2 = 10;
K3 = 20;
K4 = 64;
I = im2double(imread('watch.bmp'));
J1 = compressed_image(I, K1);       % Using function for compressing image I for a value of K
J2 = compressed_image(I, K2); 
J3 = compressed_image(I, K3); 
J4 = compressed_image(I, K4); 
figure;
imshow(I);
title('Original Image');
figure;
imshow(J1);
title('Compressed Image, K = 5');
figure;
imshow(J2);
title('Compressed Image, K = 10');
figure;
imshow(J3);
title('Compressed Image, K = 20');
figure;
imshow(J4);
title('Compressed Image, K = 64');

error1 = error_2images(I,J1);       % Error between image I and Compressed Image J for a value of K
fprintf('Error between I and J for K = %d is:\n%f\n\n',K1, error1);
error2 = error_2images(I,J2);
fprintf('Error between I and J for K = %d is:\n%f\n\n',K2, error2);
error3 = error_2images(I,J3);
fprintf('Error between I and J for K = %d is:\n%f\n\n',K3, error3);
error4 = error_2images(I,J4);
fprintf('Error between I and J for K = %d is:\n%d\n\n',K4, error4);

error_vector = zeros(64,1);    %For storing error values for all values of K from 1 to 64
for k = 1:64
    J_ = compressed_image(I, k);
    error_vector(k,1) = error_2images(I,J_);
end
figure;
plot(1:1:64, error_vector);
xlabel('Value of K');
ylabel('Error between I and J');
fprintf('Error monotonically decreases with increasing the value of K\n');

