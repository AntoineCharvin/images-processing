% Nettoyage de l'environnement MATLAB
close all
clear all
clc

% Utilisation de palettes de couleurs matplotlib
palettes_matplotlib;
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

% Création de valeurs pour Lp, ap et bp
Lp = linspace(10, 90, 100);
theta1 = pi/2;
theta2 = 7*pi/4;
h = linspace(theta2, theta1, 100);
c = 25 * ones(1, 100);
ap = c .* cos(h);
bp = c .* sin(h);

% Affichage des courbes
figure, plot(1:256, L(1,:), 2.56*[1:100], Lp, 'LineWidth', 4)
figure, plot3(a(1,:), b(1,:), L(1,:), 'bo', ap, bp, Lp, 'ro', 'MarkerSize', 10, 'MarkerEdgeColor', 'r')

% Conversion des valeurs Lp, ap et bp en une image
imbis = Lab2sRGB_Lindbloom(Lp, ap, bp);

% Création d'une image à partir des valeurs imbriquées
for i = 1:50
     image_colormapbis(i,:,1) = imbis(1,:,1);
     image_colormapbis(i,:,2) = imbis(1,:,2);
     image_colormapbis(i,:,3) = imbis(1,:,3);
end

% Affichage de l'image générée à partir des valeurs imbriquées
figure, imshow(uint8(image_colormapbis))

% Création d'une palette de couleurs à partir des valeurs imbriquées
cmbis(:,1) = 1/255 * double(imbis(1,:,1)');
cmbis(:,2) = 1/255 * double(imbis(1,:,2)');
cmbis(:,3) = 1/255 * double(imbis(1,:,3)');

% Lecture des données à partir du fichier CSV "time300.csv"
data_1 = csvread('time300.csv');

% Affichage de l'image en utilisant la palette de couleurs précédemment définie
figure, imshow(data_1, [], "colormap", cm)

% Affichage de l'image en utilisant la nouvelle palette de couleurs cmbis
figure, imshow(data_1, [], "colormap", cmbis)
