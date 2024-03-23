clear all
close all
clc

A=imread('rice.png' );
%imshow(A);

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

%figure, imshow(255*se) ;


B=imopen(A,se);
%figure, imshow(B);

ga=fspecial('gaussian',15,10);
C=imfilter(B,ga);
%figure, imshow(C);

A_unif=A-C;
%figure, imshow(A_unif);


seuil=35;
D=A_unif>seuil;
%figure, imshow(D);

E=medfilt2(D);
%figure, imshow(E);

clear sebis
radius=2;
for i=1:2*radius+1
  for j=1:2*radius+1
    if(i-(1+radius))^2+(j-(1+radius))^2<radius^2
      sebis(i,j)=1;
    else
      sebis(i,j)=0;
    end
  end
end

F=imerode(E,sebis);
Fp=imerode(F,sebis);
%Fpp=imerode(Fp,sebis);
%figure, imshow(Fp);



data=regionprops(Fp);
size(data)

FpLabel=bwlabel(Fp);
%imshow(FpLabel,[]);

grain=(FpLabel==17);
%figure, imshow(grain,[]);

aires=[data.Area];
figure, hist(aires);