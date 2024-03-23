close all
clc

seuil=35;
D=A_unif>seuil;
figure, imshow(D)

E=medfilt2(D);
figure, imshow(E)

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
figure, imshow(Fp)
