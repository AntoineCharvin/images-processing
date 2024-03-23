close all
clear all
clc


A=imread('andromeda.bmp');
A=double(A);
B(:,:,1)=124*ones(size(A,1),size(A,2));
B(:,:,2)=31*ones(size(A,1),size(A,2));
B(:,:,3)=210*ones(size(A,1),size(A,2));

Maskee=zeros(size(A,1),size(A,2));

Maskee(100:170,150:249)=ones(71,100);

A_Maskee_bis(:,:,1)=A(:,:,1).*Maskee+B(:,:,1).*(1-Maskee);
A_Maskee_bis(:,:,2)=A(:,:,2).*Maskee+B(:,:,2).*(1-Maskee);
A_Maskee_bis(:,:,3)=A(:,:,3).*Maskee+B(:,:,3).*(1-Maskee);

A_Maskee_bis=uint8(A_Maskee_bis);
imshow(A_Maskee_bis)


