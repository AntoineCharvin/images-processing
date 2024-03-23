close all
clear all
clc

A=imread('andromeda.bmp');
B(1:size(A,1),1:size(A,2),1:3)=A(1:size(A,1),1:size(A,2),1:3);
B(50:149,50:149,1)=255;
B(50:149,50:149,2)=0;
B(50:149,50:149,3)=0;

imshow(B)