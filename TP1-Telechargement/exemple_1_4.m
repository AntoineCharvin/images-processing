close all
clear all
clc

A=imread('eight_salt_pepper.bmp');
imshow(A)
%ga=fspecial('gaussian',5,3);
%B=imfilter(A,ga);
%figure, imshow(B)
%C=medfilt2(A);
%figure, imshow(C)
so=fspecial('sobel')
D1=uint8(imfilter(A,so));
D2=uint8(imfilter(A,-so));
D3=uint8(imfilter(A,so'));
D4=uint8(imfilter(A,-so'));

figure, imshow(D1+D2+D3+D4)

%C=medfilt2(A,[3 3]);
%imshow(C)

