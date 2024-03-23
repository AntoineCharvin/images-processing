close all
clear all
clc

A=imread('circles.png');
imshow(uint8(255*A))
A=A(:,:,1);
se=logical(ones(3,3));
B=imdilate(A,se);
figure, imshow(B,[])
