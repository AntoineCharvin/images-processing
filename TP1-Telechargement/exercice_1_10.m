close all
clear all
clc


for i=1:200
  for j=1:300
    if (i-100)^2+(j-150)^2>1000
      B(i,j,1)=200;
      B(i,j,2)=200;
      B(i,j,3)=200;
    else
      B(i,j,1)=255;
      B(i,j,2)=0;
      B(i,j,3)=0; 
    end
   end
end

B=uint8(B);
imshow(B)