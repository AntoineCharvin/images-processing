close all
clear all
clc

A=imread('andromeda.bmp');
for i=1:size(A,1)
  for j=1:size(A,2)
    B(i,j,1)=A(i,j,1);
    B(i,j,2)=A(i,j,2);
    B(i,j,3)=A(i,j,3);
   end
end

imshow(B)
imwrite(B,'andromeda\_copiee.bmp');
    