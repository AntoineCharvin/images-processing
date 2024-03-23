close all
clear all
clc


for i=1:200
  for j=1:300
    if i>2/3*j
      B(i,j,1)=0;
      B(i,j,2)=0;
      B(i,j,3)=0;
    else
      B(i,j,1)=255;
      B(i,j,2)=0;
      B(i,j,3)=0; 
    end
   end
end

imshow(B)