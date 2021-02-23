function [error] = error_2images(A,B)
[m, n ,c] = size(A);  %For computing error between two 3D matrices
sum = 0;
for i = 1:m
    for j = 1:n
        for k = 1:c
            sum = sum + (A(i,j,k) - B(i,j,k))^2;
        end
    end
end
error = sqrt(sum);
end

