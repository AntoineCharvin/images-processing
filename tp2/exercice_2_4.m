% Fermeture de toutes les figures ouvertes, nettoyage des variables et effacement de la console
close all
clear all
clc

% Lecture de l'image 'fabric.png' et affichage
A = imread('fabric.png');
imshow(A)
% Conversion de l'image en format numérique double
A = double(A);

% Pixels de référence
i1 = 106; j1 = 387; i2 = 93; j2 = 406; i3 = 87; j3 = 409;
i4 = 59; j4 = 400; i5 = 93; j5 = 443; i6 = 68; j6 = 388; i7 = 187; j7 = 412;

% Conversion de l'image du format sRGB en CIELAB
[L, a, b] = sRGB2Lab_Lindbloom(A);

% Stockage des valeurs de référence de chaque pixel spécifié
L1 = L(i1, j1); a1 = a(i1, j1); b1 = b(i1, j1);
L2 = L(i2, j2); a2 = a(i2, j2); b2 = b(i2, j2);
L3 = L(i3, j3); a3 = a(i3, j3); b3 = b(i3, j3);
L4 = L(i4, j4); a4 = a(i4, j4); b4 = b(i4, j4);
L5 = L(i5, j5); a5 = a(i5, j5); b5 = b(i5, j5);
L6 = L(i6, j6); a6 = a(i6, j6); b6 = b(i6, j6);
L7 = L(i7, j7); a7 = a(i7, j7); b7 = b(i7, j7);

%% Version Lab
% Calcul de la distance colorimétrique de chaque pixel par rapport aux valeurs de référence
Dist1 = sqrt((L - L1).^2 + (a - a1).^2 + (b - b1).^2);
Dist2 = sqrt((L - L2).^2 + (a - a2).^2 + (b - b2).^2);
Dist3 = sqrt((L - L3).^2 + (a - a3).^2 + (b - b3).^2);
Dist4 = sqrt((L - L4).^2 + (a - a4).^2 + (b - b4).^2);
Dist5 = sqrt((L - L5).^2 + (a - a5).^2 + (b - b5).^2);
Dist6 = sqrt((L - L6).^2 + (a - a6).^2 + (b - b6).^2);
Dist7 = sqrt((L - L7).^2 + (a - a7).^2 + (b - b7).^2);

% Sélection de la distance minimale pour chaque pixel
test = min(min(min(min(min(min(Dist1, Dist2), Dist3), Dist4), Dist5), Dist6), Dist7);

% Création de nouvelles images L, a, b en utilisant la distance minimale
L_palette = L1*(test == Dist1) + L2*(test == Dist2) + L3*(test == Dist3) + ...
            L4*(test == Dist4) + L5*(test == Dist5) + L6*(test == Dist6) + L7*(test == Dist7);
a_palette = a1*(test == Dist1) + a2*(test == Dist2) + a3*(test == Dist3) + ...
            a4*(test == Dist4) + a5*(test == Dist5) + a6*(test == Dist6) + a7*(test == Dist7);
b_palette = b1*(test == Dist1) + b2*(test == Dist2) + b3*(test == Dist3) + ...
            b4*(test == Dist4) + b5*(test == Dist5) + b6*(test == Dist6) + b7*(test == Dist7);

% Conversion des images L, a, b en espace colorimétrique sRGB et affichage
Image_palette = Lab2sRGB_Lindbloom(L_palette, a_palette, b_palette);
figure, imshow(Image_palette)

% Calcul des pourcentages de pixels correspondant à chaque valeur de référence
p1 = sum(sum(test == Dist1)) / (480 * 640);
p2 = sum(sum(test == Dist2)) / (480 * 640);
p3 = sum(sum(test == Dist3)) / (480 * 640);
p4 = sum(sum(test == Dist4)) / (480 * 640);
p5 = sum(sum(test == Dist5)) / (480 * 640);
p6 = sum(sum(test == Dist6)) / (480 * 640);
p7 = sum(sum(test == Dist7)) / (480 * 640);

%% Version ab
alpha = 0.2;
% Calcul de la distance en mettant plus de poids sur les composantes a et b
Dist1 = sqrt(alpha*(L - L1).^2 + (a - a1).^2 + (b - b1).^2);
Dist2 = sqrt(alpha*(L - L2).^2 + (a - a2).^2 + (b - b2).^2);
Dist3 = sqrt(alpha*(L - L3).^2 + (a - a3).^2 + (b - b3).^2);
Dist4 = sqrt(alpha*(L - L4).^2 + (a - a4).^2 + (b - b4).^2);
Dist5 = sqrt(alpha*(L - L5).^2 + (a - a5).^2 + (b - b5).^2);
Dist6 = sqrt(alpha*(L - L6).^2 + (a - a6).^2 + (b - b6).^2);
Dist7 = sqrt(alpha*(L - L7).^2 + (a - a7).^2 + (b - b7).^2);

% Sélection de la distance minimale pour chaque pixel
test = min(min(min(min(min(min(Dist1, Dist2), Dist3), Dist4), Dist5), Dist6), Dist7);

% Création de nouvelles images L, a, b en utilisant la distance minimale
L_palette = L1*(test == Dist1) + L2*(test == Dist2) + L3*(test == Dist3) + ...
            L4*(test == Dist4) + L5*(test == Dist5) + L6*(test == Dist6) + L7*(test == Dist7);
a_palette = a1*(test == Dist1) + a2*(test == Dist2) + a3*(test == Dist3) + ...
            a4*(test == Dist4) + a5*(test == Dist5) + a6*(test == Dist6) + a7*(test == Dist7);
b_palette = b1*(test == Dist1) + b2*(test == Dist2) + b3*(test == Dist3) + ...
            b4*(test == Dist4) + b5*(test == Dist5) + b6*(test == Dist6) + b7*(test == Dist7);

% Conversion des images L, a, b en espace colorimétrique sRGB et affichage
Image_palette = Lab2sRGB_Lindbloom(L_palette, a_palette, b_palette);
figure, imshow(Image_palette)
