close all
clear all

A = imread('holes.jpg');
seuil = 10;
B = A(:,:,1)<seuil;
imshow(B)