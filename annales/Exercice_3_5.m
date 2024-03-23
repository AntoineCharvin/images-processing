% Nettoyage de l'environnement de travail
clear all
close all
clc

% Lecture de l'image 'trame-conventionnelle.jpg'
ima = imread('trame-conventionnelle.jpg');
% Conversion en image en niveau de gris et renversement vertical
Im_NB = double(flipud(ima(:, 101:350)));
% Obtention des dimensions de l'image
taille = size(Im_NB);

% Affichage de l'image en niveaux de gris
figure(1)
imshow(uint8(Im_NB))

% Transformation de Fourier de l'image
Im_TF = fft2(Im_NB);
% Réarrangement des quadrants de la transformation de Fourier
Im_TF_centr = Im_TF([taille(1)/2+1:taille(1) 1:taille(2)/2], [taille(1)/2+1:taille(1) 1:taille(2)/2]);

% Facteur de normalisation
norm = 256 / size(Im_NB, 1) / size(Im_NB, 2);
% Affichage de la transformation de Fourier normalisée
figure(2)
imshow(uint8(norm * abs(Im_TF_centr)))

% Création d'un masque pour le filtrage
x = [1:taille(1)];
y = [1:taille(2)];
[xx, yy] = meshgrid(x, y);
k_cut = 25;  % Rayon du masque
mask = ((xx - 125).^2 + (yy - 125).^2) < k_cut^2;
figure, imshow(mask)

% Application du masque à la transformation de Fourier centrée
Im_TF_centr_filtr = Im_TF_centr .* mask;
% Affichage de la transformation de Fourier filtrée
figure, imshow(uint8(abs(norm * Im_TF_centr_filtr)))

% Réarrangement des quadrants de la transformation de Fourier filtrée
Im_TF_filtr = Im_TF_centr_filtr([taille(1)/2+1:taille(1) 1:taille(2)/2], [taille(1)/2+1:taille(1) 1:taille(2)/2]);

% Réinitialisation du facteur de normalisation
norm = 1;
% Reconstruction et affichage de l'image après filtrage (détramage)
figure, imshow(uint8(abs(norm * ifft2(Im_TF_filtr)))) % Image détramée
