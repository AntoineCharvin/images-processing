close all
clear all
clc

A=imread('bubbles.bmp');
imshow(A)
taille_masque=40;
se=logical(ones(taille_masque,taille_masque));
B=imopen(A,se);
figure, imshow(B)