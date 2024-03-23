clear all
close all
clc
pkg load image

% Lecture image
Image = imread("Sable1.png");
%Image = double(Image);

% Dimensions en pixels
Largeur = size(Image, 1);
Longueur = size(Image, 2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1)a) Histogramme de l'image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Extraction des canaux rouge, vert et bleu
R = Image(:,:,1);
V = Image(:,:,2);
B = Image(:,:,3);

[counts, x] = imhist(R, 256);
figure
subplot(311), plot(x, counts, "linewidth", 4)
title("Histogramme des valeurs rouges")

[counts, x] = imhist(V, 256);
subplot(312), plot(x, counts, "linewidth", 4)
title("Histogramme des valeurs  Vertes")

[counts, x] = imhist(B, 256);
subplot(313), plot(x, counts, "linewidth", 4)
title("Histogramme des valeurs bleues")

% Récupération du maximum des trois canaux
Val = max(Image,[],3);
% Création histogramme
[counts, x] = imhist(Val, 256);
% Affichage
figure, plot(x, counts, "linewidth", 4)
title("Histogramme global - Sable1.png")

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1)b) Application seuil à l'image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

seuil = 240;
Image_gray = rgb2gray(Image);
% Application du seuil
Image_seuillee = Image_gray > seuil;

% Affichage
figure, imshow(Image_seuillee);
title('Image seuillée')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2)a) Distribution de la taille des grains
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Affichage du nombre de grains de sable
data = regionprops(Image_seuillee);
nb_grains = length(data)

% Récupération des aires des grains isolés
aires = [data.Area];
% Taille moyenne des grains
aire_moyenne = sum(aires)/length(aires)
% Ecart-type
ecart_type = std(aires)

% Histogramme des aires des grains de sable
figure, hist(aires, 100)
title("Histogramme des aires des grains")

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2)b) Densité surfacique de grains par cm2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Dimensions image (cm)
L_cm = 79.83;
l_cm = 41.95;

% Densité surfacique en cm2: nb_grains/Surface
dens_surf = nb_grains/(L_cm*l_cm)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2)c) Surface moyenne occupée par les grains
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% On divise la somme des aires par l'aire totale
Surf_moy_occupee = sum(aires)/(L_cm*l_cm)

% Surface moyenne occupée par un seul grain
surf_moy_grain = aire_moyenne/(L_cm*l_cm)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3)a) Rognage de l'image et recalcul densité
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Nouvelle dimension de la zone (en pixels)
L = 400;

%{
% création masque
Mask = zeros(Largeur, Longueur);
Mask(floor(Largeur/2)-90:floor(Largeur/2)-90+L, floor(Longueur/2):floor(Longueur/2)+L) = 1;
% Application du masque
Image_rognee = Image.*Mask;
%}

% Creation directe image rognnee
%Image_rognee = Image(floor(Largeur/2)-90:floor(Largeur/2)-90+L, floor(Longueur/2):floor(Longueur/2)+L);
Image_rognee = Image(450:950, 1100:1500, :);
% Affichage image rognnee
figure, imshow(uint8(Image_rognee))
title("Image rognée")

% Ré-application du seuil
% Image_rognee_seuillee = Image_rognee(:,:,1) < seuil;
Image_rognee_gray = rgb2gray(Image_rognee);
% Application du seuil
Image_rognee_seuillee = Image_rognee_gray < seuil;
% Affichage
figure, imshow(~Image_rognee_seuillee);
title('Image rognee seuillée')

% Re-calcul des éléments
data_rognee = regionprops(~Image_rognee_seuillee);
nb_grains_rognee = length(data_rognee)

% Nouvelle densité moyenne
dens_surf = nb_grains_rognee/(L_cm*l_cm)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3)b) Histogramme de la distribution dans carrés
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Constantes
Nb_tirages = 1000;
Largeur_carre = 20; % En pixels

% Variables pour coordonnées du pixel où commence le carré
x = 0;
y = 0;

% Tableaux ppour stockage des résultats
Nb_grains = zeros(1,Nb_tirages);

% Début itérations
[rowss, cols,~] = size(Image_rognee_seuillee);
close all
% Début itérations
for i = 1:Nb_tirages

  x = randi([1, rowss - 19]);
  y = randi([1, cols - 19]);

  % Création carré à partir du pixel en (x,y)
  carre = Image_rognee_seuillee(x:x+19,y:y+19,:);


  % Récupération du nombre de grains de sable
  nb = regionprops(~carre, 'Area');
  % Stockage dans tableau dédié
  Nb_grains(i) = size([nb.Area],2);
end

% Affichage des résultats
figure, hist(Nb_grains);
title("Histogramme nombres de grains obtenus dans carrés de (20,20)")




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3)c) Fitting à la distribution de poisson
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

lambda = L_cm*l_cm*dens_surf;

PoissonEqn = ''
