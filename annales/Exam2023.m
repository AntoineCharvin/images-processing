clear all;
close all;
clc;

% Question 1
A = imread('ursinia_abrotanifolia_original.jpg');
imshow(A);

pixel1 = [700 400];
pixel2 = [640 570];
pixel3 = [540 460];

% Question 2
MatA = [2*(pixel1(1)-pixel2(1)) 2*(pixel1(2)-pixel2(2)); 2*(pixel1(1)-pixel3(1)) 2*(pixel1(2)-pixel3(2))];
MatB = [pixel1(1)^2 + pixel1(2)^2 - pixel2(1)^2 - pixel2(2)^2; pixel1(1)^2 + pixel1(2)^2 - pixel3(1)^2 - pixel3(2)^2];
MatX = inv(MatA)*MatB;

center = [MatX(1) MatX(2)];
printf("Center of the circle is: (%d, %d)\n", center(1), center(2));

% Question 3
radius = sqrt((pixel1(1)-center(1))^2 + (pixel1(2)-center(2))^2);
A1 = A;

% Question 4
pixel1_ext = [880 300];
pixel2_ext = [375 350];
pixel3_ext = [650 770];

radius_ext = sqrt((pixel1_ext(1)-center(1))^2 + (pixel1_ext(2)-center(2))^2);
condition = @(i,j) sqrt( (i-center(1))^2 + (j-center(2))^2);

parfor i = 1:size(A1,1)
    parfor j = 1:size(A1,2)
        if ( condition(i,j) > 0.9*radius_ext || condition(i,j) < 2.2*radius)
          A1(i,j,:) = 0;
        endif
    end
end

imshow(A1);

% Question 5
A_lab = rgb2lab(A1);

% Question 6
threshold_value = 50; % Adjust this based on your observations
binary_image = A_lab(:,:,1) > threshold_value; 
se = strel('square', 3); % Adjust the size as needed
binary_image_clean = imopen(binary_image, se);

% Question 7
[labeledImage, numberOfPetals] = bwlabel(binary_image_clean);
petalProps = regionprops(labeledImage, 'Area'); % Extract area of each petal
fprintf('Number of petals: %d\n', numel(petalProps));

