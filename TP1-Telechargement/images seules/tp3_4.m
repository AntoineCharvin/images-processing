close all
clear all

% A = imread('circles.png');
% A = A(:,:,1);
% se = logical(ones(5,5));
% B = imdilate(A, se);
% imshow(B,[])

A = imread('bubbles.bmp');
taille_masque = 40;
se = logical(ones(taille_masque, taille_masque));
B = imopen(A,se);
imshow(B)