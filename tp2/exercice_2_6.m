% Nettoyage de l'environnement MATLAB
clear all
close all
clc

% Utilisation de palettes de couleurs matplotlib
palettes_matplotlib;

% Sélection de la palette "viridis"
cm = viridis_data;

% Initialisation d'une matrice pour stocker les couleurs de la palette
for i = 1:50
     image_colormap(i,:,1) = 255 * cm(:,1);
     image_colormap(i,:,2) = 255 * cm(:,2);
     image_colormap(i,:,3) = 255 * cm(:,3);
end

% Affichage de l'image générée à partir de la palette de couleurs
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

% Affichage des images en utilisant la palette de couleurs précédemment définie
figure, imshow(data_1, [], "colormap", cm)
figure, imshow(data_2, [], "colormap", cm)
