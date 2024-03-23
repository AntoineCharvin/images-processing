% Nettoyage de l'environnement de travail
clear all
close all
clc

% Définition des matrices de conversion RGB vers XYZ et XYZ vers RGB
RGBtoXYZ = [0.4124564, 0.3575761, 0.1804375; 0.2126729, 0.7151522, 0.0721750; 0.0193339, 0.1191920, 0.9503041];
XYZtoRGB = [3.2404542, -1.5371385, -0.4985314; -0.9692660, 1.8760108, 0.0415560; 0.0556434, -0.2040259, 1.0572252];
% Calcul de l'illuminant D65
D65 = sum(RGBtoXYZ, 2);

% Lecture de l'image 'lena_std.tif'
ima = imread('lena_std.tif');

% Séparation des canaux Rouge, Vert, Bleu
R = double(ima(:, :, 1));
G = double(ima(:, :, 2));
B = double(ima(:, :, 3));

% Conversion de l'image RGB en XYZ
Xn = (RGBtoXYZ(1, 1) * R + RGBtoXYZ(1, 2) * G + RGBtoXYZ(1, 3) * B) / D65(1);
Yn = (RGBtoXYZ(2, 1) * R + RGBtoXYZ(2, 2) * G + RGBtoXYZ(2, 3) * B) / D65(2);
Zn = (RGBtoXYZ(3, 1) * R + RGBtoXYZ(3, 2) * G + RGBtoXYZ(3, 3) * B) / D65(3);

% Création d'une image en noir et blanc utilisant la composante Y (luminance)
LenaNB = Yn;
dim = size(LenaNB);

% Affichage de l'image en noir et blanc
figure, imshow(uint8(LenaNB))

% Transformation de Fourier de l'image en noir et blanc
Lena_TF = fft2(LenaNB);

% Normalisation pour l'affichage
norm = 200 / mean(abs(Lena_TF(:)));
% Affichage de la magnitude de la transformation de Fourier
figure, imshow(uint8(norm * abs(Lena_TF)))
% Affichage de la phase de la transformation de Fourier
figure, imshow(angle(Lena_TF), [])

% Application d'une phase aléatoire
thet = 1;
rdm_phas = exp(i * 2 * pi * rand(dim(1), dim(2)) * thet);
Lena_rdmp = rdm_phas .* Lena_TF;

% Affichage de la magnitude de la transformation de Fourier avec phase aléatoire
figure, imshow(uint8(norm * abs(Lena_rdmp)))
% Affichage de la phase de la transformation de Fourier avec phase aléatoire
figure, imshow(angle(Lena_rdmp), [])

% Reconstruction de l'image après application de la phase aléatoire
LenaFiltree = ifft2(Lena_rdmp);
% Affichage de l'image reconstruite
figure, imshow(uint8(abs(LenaFiltree)))
% Affichage de la phase de l'image reconstruite
figure, imshow(angle(LenaFiltree), [])
