% Fermeture de toutes les figures ouvertes, nettoyage des variables, et effacement de la console
close all
clear all
clc

% Lecture de l'image 'fabric.png' et affichage
A = imread('fabric.png');
imshow(A)
% Conversion de l'image en format numérique double
A = double(A);

% Définition des pixels de référence
i1 = 106; j1 = 387; i2 = 93; j2 = 406; i3 = 87; j3 = 409;
i4 = 59; j4 = 400; i5 = 93; j5 = 443; i6 = 68; j6 = 388; i7 = 187; j7 = 412;

% Conversion de l'image du format sRGB en CIELAB
[L, a, b] = sRGB2Lab_Lindbloom(A);

% Stockage des valeurs de référence de chaque pixel spécifié
L1 = L(i1, j1); a1 = a(i1, j1); b1 = b(i1, j1);
% Répétition de ce processus pour chaque pixel de référence (L2, a2, b2, etc.)

%% Traitement en espace colorimétrique Lab
% Calcul de la distance colorimétrique de chaque pixel par rapport aux valeurs de référence
Dist1 = sqrt((L - L1).^2 + (a - a1).^2 + (b - b1).^2);
% Répétition du calcul de distance pour chaque set de valeurs de référence (Dist2, Dist3, etc.)

% Sélection de la distance minimale pour chaque pixel
test = min(min(min(min(min(min(Dist1, Dist2), Dist3), Dist4), Dist5), Dist6), Dist7);

% Création de nouvelles images L, a, b en utilisant la distance minimale
L_palette = L1*(test == Dist1) + L2*(test == Dist2) + L3*(test == Dist3) + ...
            L4*(test == Dist4) + L5*(test == Dist5) + L6*(test == Dist6) + L7*(test == Dist7);
% Répétition du processus pour créer les images a_palette et b_palette

% Conversion des images L, a, b en espace colorimétrique sRGB et affichage
Image_palette = Lab2sRGB_Lindbloom(L_palette, a_palette, b_palette);
figure, imshow(Image_palette)

%% Traitement en se concentrant sur les composantes a et b
alpha = 0.2;
% Calcul de la distance en mettant plus de poids sur les composantes a et b
Dist1 = sqrt(alpha*(L - L1).^2 + (a - a1).^2 + (b - b1).^2);
% Répétition du calcul de distance pour chaque set de valeurs de référence (Dist2, Dist3, etc.)

% Sélection de la distance minimale pour chaque pixel
test = min(min(min(min(min(min(Dist1, Dist2), Dist3), Dist4), Dist5), Dist6), Dist7);

% Création de nouvelles images L, a, b en utilisant la distance minimale
L_palette = L1*(test == Dist1) + L2*(test == Dist2) + L3*(test == Dist3) + ...
            L4*(test == Dist4) + L5*(test == Dist5) + L6*(test == Dist6) + L7*(test == Dist7);
% Répétition du processus pour créer les images a_palette et b_palette

% Conversion des images L, a, b en espace colorimétrique sRGB et affichage
Image_palette = Lab2sRGB_Lindbloom(L_palette, a_palette, b_palette);
figure, imshow(Image_palette)
