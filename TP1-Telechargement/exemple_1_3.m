close all
clear all
clc
A=imread('andromeda.bmp');
R=A(:,:,1);
V=A(:,:,2);
B=A(:,:,3);
Val=max(A,[],3);
[count,x]=imhist(R,256);
plot(x,count,"linewidth",4)

[count,x]=imhist(Val,256);
figure, plot(x,count,"linewidth",4)