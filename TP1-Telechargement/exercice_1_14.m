close all
clear all
clc


A1=imread('Signac_1.bmp');
A1=double(A1);
A2=zeros(size(A1));
A2(:,:,1)=124*ones(size(A1,1),size(A1,2));
A2(:,:,2)=31*ones(size(A1,1),size(A1,2));
A2(:,:,3)=210*ones(size(A1,1),size(A1,2));

for i=1:size(A1,1)
  for j=1:size(A1,2)
    if (i-size(A1,1)/2)^2+(j-size(A1,2)/2)^2<(size(A1,1)/5)^2
      Maskee(i,j)=1;
    else
      Maskee(i,j)=0;
    end
  end
end

A_Maskee(:,:,1)=A1(:,:,1).*Maskee+A2(:,:,1).*(1-Maskee);
A_Maskee(:,:,2)=A1(:,:,2).*Maskee+A2(:,:,2).*(1-Maskee);
A_Maskee(:,:,3)=A1(:,:,3).*Maskee+A2(:,:,3).*(1-Maskee);
A_Maskee=uint8(A_Maskee);
imshow(A_Maskee)