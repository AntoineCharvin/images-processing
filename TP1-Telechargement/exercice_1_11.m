close all
clear all
clc


for i=1:200
  for k=1:10
    for j=50*(k-1)+1:k*50
      B(i,j)=uint8((k-1)/9*255.0);
    end
  end
end

imshow(B)

for i=1:200
  for k=1:10
    for j=50*(k-1)+1:k*50
      B(i,j,1)=255;
      B(i,j,2)=uint8((k-1)/9*255.0);
      B(i,j,3)=uint8((k-1)/9*255.0);
    end
  end
end

figure, imshow(B)