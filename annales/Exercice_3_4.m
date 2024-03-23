% Nettoie l'environnement de travail
clear all
close all
clc

% Lecture de l'image 'lena_std.tif'
ima = imread('lena_std.tif');
% Obtention des dimensions de l'image
taille = size(ima);
% Transformation de Fourier bidimensionnelle de l'image
ima_TF = fft2(ima);
% Réarrangement des quadrants de la transformation de Fourier
ima_TF = ima_TF([taille(1)/2+1:taille(1) 1:taille(2)/2],[taille(1)/2+1:taille(1) 1:taille(2)/2]);

% Création des grilles pour les coordonnées spatiales
kxx = [1:512];
kyy = [1:512];
[kx, ky] = meshgrid(kxx, kyy);
% Création du filtre passe-bas Filt1 basé sur la distance euclidienne
Filt1 = ((kx - 256).^2 + (ky - 256).^2).^(0.5);
Filt1 = Filt1 / max(Filt1(:));
% Affichage du filtre Filt1
figure, imshow(Filt1, [])

% Paramètres pour le filtre Filt2
k_cut = 20;
alpha = 1;
% Création du filtre passe-bas exponentiel Filt2
Filt2 = exp(-(abs((kx - 256) + i * (ky - 256)) / k_cut).^alpha);
Filt2 = Filt2 / max(Filt2(:));
% Affichage du filtre Filt2
figure, imshow(Filt2, [])

% Combinaison des filtres Filt1 et Filt2 en Filt3
Filt3 = Filt1 .* Filt2;
Filt3 = Filt3 / max(Filt3(:));
% Affichage du filtre combiné Filt3
figure, imshow(Filt1 .* Filt2, [])

% Application du filtre Filt3 sur l'image transformée
ima_TF_filt = ima_TF .* Filt3;
% Réarrangement des quadrants de l'image filtrée
ima_TF_filt = ima_TF_filt([taille(1)/2+1:taille(1) 1:taille(2)/2],[taille(1)/2+1:taille(1) 1:taille(2)/2]);

% Reconstruction de l'image par transformation de Fourier inverse
ima_filt = ifft2(ima_TF_filt);
% Affichage de l'image filtrée et transformée
figure, imshow(uint8(abs(ima_filt)), [])
