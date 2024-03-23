close all
clear all
clc

A=imread('holes_complete.bmp');
seuil=5;
B=A(:,:,1)<seuil;
imshow(B)

taille_masque=5;
se=ones(taille_masque,taille_masque);
C=imclose(B,se);
figure, imshow(C)

D=imopen(C,se);
figure, imshow(D)