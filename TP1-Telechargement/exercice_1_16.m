close all
clear all
clc

A=zeros(600,600,3);

A(:,:,1)=27*ones(size(A,1),size(A,2));
A(:,:,2)=180*ones(size(A,1),size(A,2));
A(:,:,3)=255*ones(size(A,1),size(A,2));

Masquee1=zeros(size(A,1),size(A,2));
Masquee2=zeros(size(A,1),size(A,2));
Masquee3=zeros(size(A,1),size(A,2));

Masquee1(21:320,21:320)=ones(300,300);
Masquee2(151:450,151:450)=ones(300,300);
Masquee3(281:580,281:580)=ones(300,300);

Masquee_intersection=Masquee1.*Masquee2.*Masquee3;
Masquee_union12=Masquee1+Masquee2-Masquee1.*Masquee2;
Masquee_union123=Masquee_union12+Masquee3-Masquee_union12.*Masquee3;

A_Masquee_inter=A.*Masquee_intersection;
A_Masquee_union=A.*Masquee_union123;

imshow(uint8(A_Masquee_inter))
figure, imshow(uint8(A_Masquee_union))