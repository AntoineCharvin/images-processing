% Fermeture de toutes les figures ouvertes
close all

% Suppression de toutes les variables de l'espace de travail
clear all

% Effacement de la fenêtre de commande
clc

% Lecture de l'image 'impression_soleil_levant.jpg' et stockage dans 'Image'
Image = imread('impression_soleil_levant.jpg');

% Normalisation des valeurs de l'image de [0,255] à [0,1]
I = double(Image)/255;

% Conversion de sRGB en RGB linéaire selon Lindbloom
I_Comp = (I <= 0.04045) .* I / 12.92 + (I > 0.04045) .* ((I + 0.055) / 1.055) .^ 2.4;

% Conversion de RGB linéaire en XYZ selon Lindbloom
X = I_Comp(:, :, 1) * 0.4124564 + I_Comp(:, :, 2) * 0.3575761 + I_Comp(:, :, 3) * 0.1804375;
Y = I_Comp(:, :, 1) * 0.2126729 + I_Comp(:, :, 2) * 0.7151522 + I_Comp(:, :, 3) * 0.0721750;
Z = I_Comp(:, :, 1) * 0.0193339 + I_Comp(:, :, 2) * 0.1191920 + I_Comp(:, :, 3) * 0.9503041;

% Définition de l'illuminant (D65 dans la plupart des cas)
X1 = 0.9504;
Y1 = 1;
Z1 = 1.0888;

% Normalisation des composantes XYZ par rapport à l'illuminant
x = X / X1;
Y = Y / Y1;
Z = Z / Z1;

% Conversion de XYZ en CIELAB selon Lindbloom
epsilon = 0.008856;
kappa = 903.3;
fx = (X > epsilon) .* X .^ (1 / 3) + (X <= epsilon) .* (kappa * X + 16) / 116;
fy = (Y > epsilon) .* Y .^ (1 / 3) + (Y <= epsilon) .* (kappa * Y + 16) / 116;
fz = (Z > epsilon) .* Z .^ (1 / 3) + (Z <= epsilon) .* (kappa * Z + 16) / 116;

L = 116 * fy - 16;
a = 500 * (fx - fy);
b = 200 * (fy - fz);

% Affichage de la composante L de LAB (luminance)
imshow(L, [])

% Conversion de LAB en XYZ selon Lindbloom
fynew = (L + 16) / 116;
fxnew = fynew + a / 500;
fznew = fynew - b / 200;

Xnew = (fxnew .^ 3 > epsilon) .* fxnew .^ 3 + (fxnew .^ 3 <= epsilon) .* (116 * fxnew - 16) / kappa;
Ynew = (L > kappa * epsilon) .* ((L + 16) / 116) .^ 3 + (L <= kappa * epsilon) .* L / kappa;
Znew = (fznew .^ 3 > epsilon) .* fznew .^ 3 + (fznew .^ 3 <= epsilon) .* (116 * fznew - 16) / kappa;

Xnew = Xnew * X1;
Ynew = Ynew * Y1;
Znew = Znew * Z1;

% Conversion de XYZ en RGB linéaire selon Lindbloom
RGB_new(:, :, 1) = Xnew .* 3.2404542 + Ynew .* (-1.5371385) + Znew .* (-0.4985314);
RGB_new(:, :, 2) = Xnew .* (-0.9692660) + Ynew .* 1.8760108 + Znew .* 0.0415560;
RGB_new(:, :, 3) = Xnew .* 0.0556434 + Ynew .* (-0.2040259) + Znew .* 1.0572252;

% Conversion de RGB linéaire en sRGB
RGB_new = (RGB_new <= 0.0031308) .* (12.92 * RGB_new) + (RGB_new > 0.0031308) .* (1.055 * RGB_new .^ (1 / 2.4) - 0.055);

% Conversion des valeurs RGB en entiers [0, 255] et en format uint8
Z = (255 * RGB_new);
newImage = uint8(Z);

% Affichage de l'image résultante
figure, imshow(newImage);
