close all
clear all
clc

A=imread('eight_salt_pepper.bmp');
imshow(A)
%A=double(A);
so=fspecial('sobel')
D0=conv2(A,so);
D1=conv2(A,-so);
D2=conv2(A,so');
D3=conv2(A,-so');
figure,imshow(uint8(D0))
figure,imshow(uint8(D1))
figure,imshow(uint8(D2))
figure,imshow(uint8(D3))

figure, imshow(uint8(abs(D0)));
figure, imshow(uint8(abs(D2)));

figure, imshow(uint8(abs(D2)+abs(D0)));




