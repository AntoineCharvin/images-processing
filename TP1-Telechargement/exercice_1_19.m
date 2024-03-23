close all
clear all
clc

A=imread('circles.png');
A=A(:,:,1);
se=[0 0 1 0 0; 
0 1 1 1 0;
1 1 1 1 1;
0 1 1 1 0;
0 0 1 0 0]
B=imerode(A,se);
imshow(B,[])
