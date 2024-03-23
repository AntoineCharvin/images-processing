% Nettoyage de l'environnement de travail
clear all
close all
clc

% Lecture de l'image 'Quasicrystal1.jpg'
ima = imread('Quasicrystal1.jpg'); % Image de modèle quasicristal

% Séparation des canaux Rouge, Vert, Bleu de la première partie de l'image
R = double(ima(:, 1:229, 1));
G = double(ima(:, 1:229, 2));
B = double(ima(:, 1:229, 3));

% Définition des matrices de conversion RGB vers XYZ et XYZ vers RGB
RGBtoXYZ = [0.4124564, 0.3575761, 0.1804375; 0.2126729, 0.7151522, 0.0721750; 0.0193339, 0.1191920, 0.9503041];
XYZtoRGB = [3.2404542, -1.5371385, -0.4985314; -0.9692660, 1.8760108, 0.0415560; 0.0556434, -0.2040259, 1.0572252];
D65 = sum(RGBtoXYZ, 2);

% Conversion de l'image RGB en XYZ
Xn = (RGBtoXYZ(1, 1)*R + RGBtoXYZ(1, 2)*G + RGBtoXYZ(1, 3)*B) / D65(1);
Yn = (RGBtoXYZ(2, 1)*R + RGBtoXYZ(2, 2)*G + RGBtoXYZ(2, 3)*B) / D65(2);
Zn = (RGBtoXYZ(3, 1)*R + RGBtoXYZ(3, 2)*G + RGBtoXYZ(3, 3)*B) / D65(3);

% Création d'une image en niveau de gris en utilisant la composante Y
Im_NB = Yn;
% Affichage de l'image en niveau de gris
figure(1)
imshow(uint8(Im_NB))

% Obtention des dimensions de l'image
taille = size(Im_NB);

% Transformation de Fourier de l'image
Im_TF = fft2(Im_NB);
% Réarrangement des quadrants de la transformation de Fourier pour centrer les basses fréquences
Im_TF_centr = Im_TF([(taille(1)-1)/2+1:taille(1) 1:(taille(1)-1)/2], [(taille(2)-1)/2+1:taille(2) 1:(taille(2)-1)/2]);

% Sélection d'une partie de la transformation de Fourier pour l'affichage
Im_TF_disp = Im_TF_centr(60:170, 60:170);

% Facteur de normalisation
norm = 1E-9;
% Affichage de la partie sélectionnée de la transformation de Fourier
figure(3)
imshow(uint8(norm * abs(Im_TF_disp).^2))
