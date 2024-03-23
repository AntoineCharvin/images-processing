close all
clear all
clc


A1=imread('Picasso.bmp');
A1=double(A1);
A2=zeros(size(A1));
A2(:,:,1)=0*ones(size(A1,1),size(A1,2));
A2(:,:,2)=180*ones(size(A1,1),size(A1,2));
A2(:,:,3)=255*ones(size(A1,1),size(A1,2));

imshow(uint8(A2))

Maskee=zeros(size(A1,1),size(A1,2));
Maskee(223:408,45:194)=1;
Maskee(443:600,434:583)=1;

A_Maskee(:,:,1)=A1(:,:,1).*Maskee+A2(:,:,1).*(1-Maskee);
A_Maskee(:,:,2)=A1(:,:,2).*Maskee+A2(:,:,2).*(1-Maskee);
A_Maskee(:,:,3)=A1(:,:,3).*Maskee+A2(:,:,3).*(1-Maskee);

figure, imshow(uint8(A_Maskee))


A_Maskee(223:380,620:769,1:3)=A1(443:600,434:583,1:3);

figure, imshow(uint8(A_Maskee))

