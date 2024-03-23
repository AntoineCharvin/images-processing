close all
clear all
A=imread('andromeda.bmp');
R(:,:)=A(:,:,1);
V(:,:)=A(:,:,2);
B(:,:)=A(:,:,3);
Val=max(A,[],3) ;
[counts,x]=imhist(R,256);
plot(x,counts,"linewidth",4)
[counts,x]=imhist(Val,256);
figure, plot(x,counts,"linewidth",4)