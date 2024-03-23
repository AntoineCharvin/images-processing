% Nettoyage de l'environnement de travail
clear all
close all
clc

% Lecture de l'image 'vue_vigne.jpg'
ima = imread('vue_vigne.jpg'); % Position géographique : 46.9784°N 4.7592°E

% Séparation des canaux Rouge, Vert, Bleu
R = double(ima(:, :, 1));
G = double(ima(:, :, 2));
B = double(ima(:, :, 3));

% Définition des matrices de conversion RGB vers XYZ et XYZ vers RGB
RGBtoXYZ = [0.4124564, 0.3575761, 0.1804375; 0.2126729, 0.7151522, 0.0721750; 0.0193339, 0.1191920, 0.9503041];
XYZtoRGB = [3.2404542, -1.5371385, -0.4985314; -0.9692660, 1.8760108, 0.0415560; 0.0556434, -0.2040259, 1.0572252];
% Calcul de l'illuminant D65
D65 = sum(RGBtoXYZ, 2);

% Conversion de l'image RGB en XYZ
Xn = (RGBtoXYZ(1, 1)*R + RGBtoXYZ(1, 2)*G + RGBtoXYZ(1, 3)*B) / D65(1);
Yn = (RGBtoXYZ(2, 1)*R + RGBtoXYZ(2, 2)*G + RGBtoXYZ(2, 3)*B) / D65(2);
Zn = (RGBtoXYZ(3, 1)*R + RGBtoXYZ(3, 2)*G + RGBtoXYZ(3, 3)*B) / D65(3);

% Création d'une image en niveau de gris en utilisant la composante Y
Im_NB = Yn;
% Affichage de l'image en niveau de gris
figure, imshow(uint8(Im_NB))

% Découpage de l'image en niveau de gris
ny = 320; nx = 200;
Im_crop = Im_NB(ny:ny+256-1, nx:nx+256-1);

% Affichage de l'image découpée et de son histogramme
figure, subplot(2, 1, 1)
imshow(uint8(Im_crop))
subplot(2, 1, 2)
hist(Im_crop(:), 100)

% Transformation de Fourier de l'image découpée
Im_TF = fft2(Im_crop);
% Réarrangement des quadrants de la transformation de Fourier
Im_TF_centr = Im_TF([129:256 1:128], [129:256 1:128]);

% Paramètres pour l'histogramme de la TF et affichage
bins = linspace(0, 10000, 50);
norma = 1E-2;
figure, subplot(2, 1, 1)
imshow(uint8(norma * abs(Im_TF_centr)))
subplot(2, 1, 2)
hist(abs(Im_TF(:)), bins)

% Seuil pour la création du masque de filtrage
seuil = 5E4;
% Création et affichage du masque de filtrage
mask = (abs(Im_TF_centr) > seuil);
figure, imshow(mask)

% Calcul de distance et échelle de conversion
A1 = [142 317];
A2 = [915 262];
dist = norm(A1 - A2);
ech = 84 / dist; % Facteur de conversion pixel -> mètre

% Taille spatiale de l'image dans la direction x
T = 256 * ech;

% Échelle de la transformation de Fourier
echf = 1 / T;

% Mesure de la distance entre deux taches du spectre
Q1 = [54, 411]; 
Q2 = [203, 378];
df = norm(Q1 - Q2) / 6 * echf; % Fréquence spatiale en m-1

% Estimation de la distance entre les rangs via la TF
dist_rang = 1 / df

% Mesure directe pour comparaison
B1 = [187, 333];
B2 = [672, 305];
dist2 = norm(B1 - B2);
drang = ech * dist2 / 50
