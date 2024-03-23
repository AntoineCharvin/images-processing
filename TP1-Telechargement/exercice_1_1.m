close all
clear all
clc

A=imread('andromeda.bmp');
for i=1:size(A,1)
  for j=1:size(A,2)
    B(i,j,1)=125;
    B(i,j,2)=125;
    B(i,j,3)=125;
   end
end

imshow(uint8(B))
imwrite(uint8(B),'andromeda_blanche.bmp');
    