close all
clear all
clc

B(1:200,1:100,1)=zeros(200,100);
B(1:200,1:100,2)=zeros(200,100);
B(1:200,1:100,3)=255*ones(200,100);

B(1:200,101:200,1)=255*ones(200,100);
B(1:200,101:200,2)=255*ones(200,100);
B(1:200,101:200,3)=255*ones(200,100);

B(1:200,201:300,1)=255*ones(200,100);
B(1:200,201:300,2)=zeros(200,100);
B(1:200,201:300,3)=zeros(200,100);

imshow(uint8(B))