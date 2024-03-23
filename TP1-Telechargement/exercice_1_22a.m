clear all
close all
clc

A=imread('rice.png' );
imshow(A)

radius=7;
for i=1:2*radius+1
  for j=1:2*radius+1
    if(i-(1+radius))^2+(j-(1+radius))^2<radius^2
      se(i,j)=1;
    else
      se(i,j)=0;
    end
  end
end

figure, imshow(255*se) 


B=imopen(A,se);
figure, imshow(B)

ga=fspecial('gaussian',15,10);
C=imfilter(B,ga);
figure, imshow(C)

A_unif=A-C;
figure, imshow(A_unif)
