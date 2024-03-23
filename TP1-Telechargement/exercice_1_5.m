close all
clear all
clc

A=imread('andromeda.bmp');
%B(1:size(A,1),1:size(A,2),1)=A(1:size(A,1),1:size(A,2),2);
%B(1:size(A,1),1:size(A,2),2)=A(1:size(A,1),1:size(A,2),1);
%B(1:size(A,1),1:size(A,2),3)=A(1:size(A,1),1:size(A,2),3);
B(:,:,1)=A(:,:,2);
B(:,:,2)=A(:,:,1);
B(:,:,3)=A(:,:,3);
imshow(B)