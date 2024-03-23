close all
clear all

A = imread('circles.png');
A = A(:,:,1);
se = logical(ones(5,5));
B = imerode(A, se);
imshow(B,[])