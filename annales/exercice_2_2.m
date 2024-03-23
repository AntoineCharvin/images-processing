% Fermeture de toutes les figures ouvertes, nettoyage des variables, et effacement de la console
close all
clear all
clc

% Lecture de l'image 'fabric.png' et conversion en format numérique double
A = imread('fabric.png');
A = double(A);

% Conversion de l'image du format sRGB en CIELAB selon Lindbloom
[L, a, b] = sRGB2Lab_Lindbloom(A);

% Définition du seuil pour la différenciation des couleurs
seuil = 20;

% Calcul de la distance colorimétrique par rapport à une couleur de référence dans l'espace CIELAB
Dist = sqrt((L - 56.705).^2 + (a - 63.492).^2 + (b - 33.118).^2);
% Calcul de la distance en teinte par rapport à la même référence
Dist_teinte = sqrt((a - 63.492).^2 + (b - 33.118).^2);

% Affichage d'une image binaire basée sur la distance colorimétrique globale
imshow(Dist < seuil)
% Affichage d'une autre image binaire basée uniquement sur la distance de la teinte
figure, imshow(Dist_teinte < seuil)
