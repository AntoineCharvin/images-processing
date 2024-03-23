close all
clear all
clc

A=imread('holes.jpg');
imshow(A)
seuil=10;
B=A(:,:,1)<seuil;
figure, imshow(B)