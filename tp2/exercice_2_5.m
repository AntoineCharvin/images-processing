% Nettoyage de l'environnement MATLAB
clear all
close all
clc

% Sélection de la colormap "jet"
colormap jet

% Récupération de la colormap sélectionnée
cm = colormap;

% Initialisation d'une matrice pour stocker les couleurs de la colormap
for i = 1:50
     image_colormap(i,:,1) = 255 * cm(:,1);
     image_colormap(i,:,2) = 255 * cm(:,2);
     image_colormap(i,:,3) = 255 * cm(:,3);
end

% Affichage de l'image générée à partir de la colormap
imshow(uint8(image_colormap))

% Conversion de l'image en espace colorimétrique CIELAB
[L, a, b] = sRGB2Lab_Lindbloom(uint8(image_colormap));

% Affichage de la première ligne de L
figure, plot(L(1,:), 'LineWidth', 4)

% Affichage en 3D des composantes a, b et L de la première ligne
figure, plot3(a(1,:), b(1,:), L(1,:), 'o', 'MarkerSize', 10, 'MarkerEdgeColor', 'r', ...
     'MarkerFaceColor', 'r')

% Lecture des données à partir des fichiers CSV "time10.csv" et "time300.csv"
data_1 = csvread('time10.csv');
data_2 = csvread('time300.csv');

% Affichage des images en utilisant la colormap précédemment définie
figure, imshow(data_1, [], "colormap", cm)
figure, imshow(data_2, [], "colormap", cm)

% Imprime la colormap "jet"
%colormap(cm)




% im=Lab2sRGB_Lindbloom(L,a,b);
% 
% 
% figure, plot3(a(1,:),b(1,:),L(1,:),'o','MarkerSize',10,'MarkerEdgeColor','r',...
%     'MarkerFaceColor','r')
% [Lp,ap,bp,c,h]=sRGB2Lab_Lindbloom(im);
% 
% figure, plot3(ap(1,:),bp(1,:),Lp(1,:),'o','MarkerSize',10,'MarkerEdgeColor','r',...
%     'MarkerFaceColor','r')
% 
% for i=1:50
%      image_colormap(i,:,1)=im(1,:,1);
%      image_colormap(i,:,2)=im(1,:,2);
%      image_colormap(i,:,3)=im(1,:,3);
% end
% 
% figure, imshow(uint8(image_colormap))
% 
% 
% cm(:,1)=1/255*double(im(1,:,1)');
% cm(:,2)=1/255*double(im(1,:,2)');
% cm(:,3)=1/255*double(im(1,:,3)');
% 
% data_1=csvread('predateurs.csv');
% data_2=csvread('proies.csv');
% 
% 
% figure, imshow(data_1,[])
% colormap(cm)
% figure, imshow(data_1,[])
% colormap parula
% 
% 
% 
% A=csvread('Linear_L_0-255.csv');
% A=csvread('cube1_0-255.csv');
% A=csvread('cubeYF_0-255.csv');
% 
% for i=1:50
%     image_spectrum(i,:,1)=A(:,1)';
%     image_spectrum(i,:,2)=A(:,2)';
%     image_spectrum(i,:,3)=A(:,3)';
% end
% 
% 
% 
% 
% 
% 
% 
% figure, plot(A,'LineWidth',3)
% figure, imshow(uint8(image_spectrum))