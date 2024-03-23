close all
clear all
clc

A=imread('circles.png');
A=A(:,:,1);
imshow(uint8(255*A))
se=[0 1 0; 1 1 1;0 1 0];
B=imerode(A,se);
B=255*B;
figure, imshow(B)
