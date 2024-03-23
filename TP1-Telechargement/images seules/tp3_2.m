close all 
clear all
% A = imread('eight_salt_pepper.bmp');
% % imshow(A)
% ga = fspecial('gaussian', 5, 3)
% B=imfilter(A,ga);
% imshow(B)

A = imread('eight_salt_pepper.bmp');
% C = medfilt2(A,[3,3]);
% imshow(C)

so = fspecial('sobel')
B = conv2(A,so);
imshow(uint8(B))