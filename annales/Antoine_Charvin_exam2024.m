%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% QUESTION 1 %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Fermeture de toutes les figures ouvertes
close all

% Suppression de toutes les variables de l'espace de travail
clear all

% Effacement de la fenêtre de commande
clc

% Lecture de l'image 'impression_soleil_levant.jpg' et stockage dans 'Image'
Image = imread('Tuiles_Voronoi.png');

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
figure,
imshow(L, [])



% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%% QUESTION 2 %%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% transformée de fourier des 3 images résultantes 
tfL = shift(shift(fft2(L), 960,1),960,2);
tfa = shift(shift(fft2(a), 960,1),960,2);
tfb = shift(shift(fft2(b), 960,1),960,2);

%%% juste pour la composante L
% Normalisation pour l'affichage
norm = 10 / mean(abs(tfL(:)));
% Affichage de la magnitude de la transformation de Fourier
figure, imshow(uint8(norm * abs(tfL)))
% Affichage de la phase de la transformation de Fourier
figure, imshow(angle(tfL), [])



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% QUESTION 3 %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



newL = tfL;
newa = tfa;
newb = tfb;

pixel1 = [900 960];
center = [960 960];
radius = sqrt((pixel1(1)-center(1))^2 + (pixel1(2)-center(2))^2);        
condition = @(i,j) sqrt( (i-center(1))^2 + (j-center(2))^2);
for i = 1:size(L)(1)
    for j = 1:size(L)(2)
        if ( condition(i,j) > 0.9*radius)
        newL(i,j,:) = 0;
        newb(i,j,:) = 0;
        newa(i,j,:) = 0;
        end
    end
end

% pour la composante L (par exemple)
figure, imshow(uint8(norm * abs(newL)));



newL_filtree = ifft2(newL);
newa_filtree = ifft2(newa);
newb_filtree = ifft2(newb);




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% QUESTION 4 %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

final_image = Lab2sRGB_Lindbloom(newL_filtree, newa_filtree, newb_filtree);
figure, imshow(final_image);




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% QUESTION 5 %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


A = imread('Tuiles_Vonoroi_filtre.png');

% Conversion de l'image en format numérique double
A = double(A);

% Définition des pixels de référence
i1 = 252-1; j1 = 75-1; 
i2 = 188-1; j2 = 57-1; 
i3 = 188-1; j3 = 16-1;
i4 = 137-1; j4 = 103-1;
i5 = 167-1; j5 = 51-1;


% Conversion de l'image du format sRGB en CIELAB
[L, a, b] = sRGB2Lab_Lindbloom(A);

% Stockage des valeurs de référence de chaque pixel spécifié
L1 = L(i1, j1); a1 = a(i1, j1); b1 = b(i1, j1);
% Répétition de ce processus pour chaque pixel de référence (L2, a2, b2, etc.)
L2 = L(i2, j2); a2 = a(i2, j2); b2 = b(i2, j2);
L3 = L(i3, j3); a3 = a(i3, j3); b3 = b(i3, j3);
L4 = L(i4, j4); a4 = a(i4, j4); b4 = b(i4, j4);
L5 = L(i5, j5); a5 = a(i5, j5); b5 = b(i5, j5);



%% Traitement en espace colorimétrique Lab
% Calcul de la distance colorimétrique de chaque pixel par rapport aux valeurs de référence
Dist1 = sqrt((L - L1).^2 + 0.1*(a - a1).^2 + 0.1*(b - b1).^2);
% Répétition du calcul de distance pour chaque set de valeurs de référence (Dist2, Dist3, etc.)
Dist2 = sqrt((L - L2).^2 + (a - a2).^2 + (b - b2).^2);
Dist3 = sqrt((L - L3).^2 + (a - a3).^2 + (b - b3).^2);
Dist4 = sqrt((L - L4).^2 + (a - a4).^2 + (b - b4).^2);
Dist5 = sqrt((L - L5).^2 + (a - a5).^2 + (b - b5).^2);


% Sélection de la distance minimale pour chaque pixel
test = min(min(min(min(min(min(Dist1, Dist2), Dist3), Dist4), Dist5)));

% Création de nouvelles images L, a, b en utilisant la distance minimale
L_palette = L1*(test == Dist1) + L2*(test == Dist2) + L3*(test == Dist3) + ...
            L4*(test == Dist4) + L5*(test == Dist5);
% Répétition du processus pour créer les images a_palette et b_palette
a_palette = a1*(test == Dist1) + a2*(test == Dist2) + a3*(test == Dist3) + ...
            a4*(test == Dist4) + a5*(test == Dist5);

b_palette = b1*(test == Dist1) + b2*(test == Dist2) + b3*(test == Dist3) + ...
            b4*(test == Dist4) + b5*(test == Dist5);


% Conversion des images L, a, b en espace colorimétrique sRGB et affichage
Image_palette = Lab2sRGB_Lindbloom(L_palette, a_palette, b_palette);
figure, imshow(Image_palette)

% %% Traitement en se concentrant sur les composantes a et b
% alpha = 0.2;
% % Calcul de la distance en mettant plus de poids sur les composantes a et b
% Dist1 = sqrt(alpha*(L - L1).^2 + (a - a1).^2 + (b - b1).^2);
% % Répétition du calcul de distance pour chaque set de valeurs de référence (Dist2, Dist3, etc.)

% % Sélection de la distance minimale pour chaque pixel
% test = min(min(min(min(min(min(Dist1, Dist2), Dist3), Dist4), Dist5), Dist6), Dist7);

% % Création de nouvelles images L, a, b en utilisant la distance minimale
% L_palette = L1*(test == Dist1) + L2*(test == Dist2) + L3*(test == Dist3) + ...
%             L4*(test == Dist4) + L5*(test == Dist5) + L6*(test == Dist6) + L7*(test == Dist7);
% % Répétition du processus pour créer les images a_palette et b_palette

% % Conversion des images L, a, b en espace colorimétrique sRGB et affichage
% Image_palette = Lab2sRGB_Lindbloom(L_palette, a_palette, b_palette);
% figure, imshow(Image_palette)



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% QUESTION 6 %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%% Dans cette question je suis reparti de l'image d'origine, car n'étant pas certain du résultat précédent
%%%%% je ne voulais pas propager une quelconque erreur 

Image = imread('Tuiles_Voronoi.png');
mask = zeros(size(Image));
mask(:,:,1)=255;
mask(:,:,2)=255;
mask(:,:,3)=255;



for i = 1:size(Image)(1)
    for j = 1:size(Image)(2)
        if ( Image(i,j,1) < 1 && Image(i,j,2) < 1 && Image(i,j,3) < 1)
        mask(i,j,1) = 0;
        mask(i,j,2) = 0;
        mask(i,j,3) = 0;
        end
    end
end
figure, imshow(mask);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% QUESTION 7 %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

threshold_value = 200; 
binary_image = mask(:,:,1) > threshold_value; 
radius = 1; % This smaller radius can help separate grains that are close together
n = 2*radius+1;
[x, y] = meshgrid(-radius:radius);
disk = (x.^2 + y.^2) <= radius^2;
se = strel('arbitrary', disk);
binary_image_clean = imopen(binary_image, se);


[labeled_image, num_objects] = bwlabel(binary_image_clean);

data = regionprops(labeled_image, "Centroid");

centres_de_masse = [data.Centroid];

fprintf("Number of centers (je suis conscient que la réponse est fausse, mais je n ai pas réussi à faire mieux): %d\n", numel(centres_de_masse));




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% QUESTION 8 %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


masques = cell(1, numel(data));
for i = 1:numel(data)
    centre = centres_de_masse(i,:);
    distances = sqrt(sum((centres_de_masse - centre).^2, 2));
    masque = distances <= min(distances);  
    masques{i} = masque;
end


k = 1; % affiche le premier masque (par exemple)
figure, imshow(masques{k});
title(['Masque pour le centre de masse numéro ', num2str(k)]);

