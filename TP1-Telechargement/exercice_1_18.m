close all
clear all
clc

A=zeros(600,600);
A(151:450,151:450)=255*ones(300,300);
imshow(uint8(A))
so=fspecial('sobel')
D1=uint8(imfilter(A,so));
D2=uint8(imfilter(A,-so));
D3=uint8(imfilter(A,so'));
D4=uint8(imfilter(A,-so'));

figure, imshow(D1+D2+D3+D4)
