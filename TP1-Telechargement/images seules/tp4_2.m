pkg load image; % Load the image package if not already loaded

% Read the image
image = imread('rice.png');

% Check if the image is RGB, if so convert to grayscale, otherwise keep it as is
if size(image, 3) == 3
    gray_image = rgb2gray(image);
else
    gray_image = image;
end

% Manually create a disk-shaped structuring element for morphological opening
radius = 3; % Adjust radius based on your image
n = 2*radius+1;
[x, y] = meshgrid(-radius:radius);
disk = (x.^2 + y.^2) <= radius^2;
se = strel('arbitrary', disk);

% Estimate the background using a morphological opening
background = imopen(gray_image, se);

% Subtract the background from the original image
subtracted_image = imsubtract(gray_image, background);

% Apply a Gaussian blur to the subtracted image
blurred_subtracted_image = imsmooth(subtracted_image, 'Gaussian', 10);

% Experiment with different threshold values
% You can manually try different thresholds to see which works best
thresh = graythresh(blurred_subtracted_image) * 0.8; % Example of manual adjustment
bw = im2bw(blurred_subtracted_image, thresh);

% Create a smaller disk-shaped structuring element for morphological operations
radius = 1; % This smaller radius can help separate grains that are close together
n = 2*radius+1;
[x, y] = meshgrid(-radius:radius);
disk = (x.^2 + y.^2) <= radius^2;
se = strel('arbitrary', disk);

% Perform morphological closing to fill in the grains
bw = imclose(bw, se);

% Perform morphological opening to remove any small noise
bw = imopen(bw, se);

% Label the connected components in the binary image
[labeled_image, num_objects] = bwlabel(bw);

% Get region properties
data = regionprops(labeled_image, 'Area', 'BoundingBox');

% Extract the area of each object
areas = [data.Area];

% Filter out small objects and large clumps that might be multiple grains
average_area = mean(areas);
std_area = std(areas);
filtered_areas = areas(areas > average_area - std_area & areas < average_area + std_area);
filtered_num_objects = numel(filtered_areas);

% Display the number of rice grains after filtering
disp(['Filtered number of rice grains: ', num2str(filtered_num_objects)]);

% Display a histogram of the filtered areas of the rice grains
% hist(filtered_areas, 50); % Adjust the number of bins as necessary

% Display the final image with rice grains labeled
imshow(label2rgb(labeled_image, 'jet', 'w', 'shuffle'));
