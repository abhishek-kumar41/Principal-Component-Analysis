function J = compressed_image(I, K)

J = zeros(size(I));

for c = 1:3
    channel = I(:,:,c);  % R, G, B channels of image
    [m, n] = size(channel);  %Size of each channel
    N = m*n/(8*8);     %No. of blocks
    x = zeros(64, N);  %For storing all data samples x_i for a channel
    for i = 1:N
        k = 0;
        p = mod(8*(i-1), n) + 1;       % p and q for finding starting index of each block
        q = 8*(floor((8*(i-1)+1)/n)) + 1;
        for j = 1:64    
            k = mod(k, 8);             % For movement along columns in each block
            l = floor((j-1)/8);         %For movement along rows in each block
            x(j,i) = channel(q+l, p+k); %Storing value to vector from block
            k = k + 1;
        end       
    end
    
    sum_x = zeros(64,1);
    for i = 1:N
        sum_x(:,1) = sum_x(:,1) + x(:,i);
    end
    mean = sum_x/N;        % Finding sample mean 
    
    sum_cov = zeros(64,64);
    for i = 1:N
        matrix_diff = x(:,i) - mean;
        sum_cov = sum_cov + matrix_diff*matrix_diff';
    end
    cov_matrix = sum_cov/N;   % Finding sample covariance matrix
    
    [V, Lambda] = eig(cov_matrix); %Eigenvalue and eigenvector of covariance matrix
    Lambda = diag(Lambda);         %Eigenvalues are at diagonal
    [Lambda, indices] = sort(Lambda, 'descend');   %Sorting eigenvalues
    V = V(:,indices);                              %Eigenvectors
    x_ = zeros(64, N);
    channel_J = zeros(m,n);        %Channel for forming compressed image
    for i = 1:N
        sum_ip = zeros(64,1);      %For finding sum of inner product as defined
        for k = 1:K                % K is the compression factor
            sum_ip = sum_ip + ((x(:,i) - mean)')*(V(:,k))*(V(:,k));
        end
        x_(:,i) = mean + sum_ip;
        
        k = 0;
        p = mod(8*(i-1), n) + 1;    % p and q as defined above
        q = 8*(floor((8*(i-1)+1)/n)) + 1;
        for j = 1:64    
            k = mod(k, 8);         %k and l as defined above
            l = floor((j-1)/8);
            channel_J(q+l, p+k) = x_(j,i);  %Storing value from data point to blocks of a channel
            k = k + 1;
        end
    end
    J(:,:,c) = channel_J;      % Storing values of each channel to form compressed image
end

end

