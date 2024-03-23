close all;
clear all;
clc;

### Chargement du package image
pkg load image;
#####################################################################################
################ Question 1.a #######################################################
#####################################################################################
Exo1 = figure(1);

A = imread('sable1.png');
A = double(A);

R = A(:,:,1);
G = A(:,:,2);
B = A(:,:,3);


[counts,x] = imhist(R,256);
subplot(3,1,1); plot(x,counts,"linewidth",2); 
title("Histogramme du canal rouge");

[counts,x] = imhist(G,256);
subplot(3,1,2); plot(x,counts,"linewidth",2);
title("Histogramme du canal vert");

[counts,x] = imhist(B,256);
subplot(3,1,3); plot(x,counts,"linewidth",2);
title("Histogramme du canal bleu");

# Recuperation des valeurs de l'histogramme
val = max(A,[],3);

# Affichage de l'histogramme
[counts,x] = imhist(val,256);

figure(2);
plot(x,counts,"linewidth",2);
title("Histogramme de l'image");


#### On veut recuperer que les grains de sables, donc que les pixels blanc aux bords
#### de l'histogramme ####

% close all;
#######################################################################################
########### Question 1.b ( seuil pour image binarisé ) ################################
#######################################################################################

Seuil = 240;

# On binarise l'image
A_seuil = A(:,:,2) < Seuil;

figure(3);
imshow(~A_seuil);
title("Image binarisé");
imwrite(~A_seuil,'sable1_bin.png');

###########################################################################################
#### Question 2.a #########################################################################
###########################################################################################
close all;

# Distribution de la taille des grains de sable
figure(4);
BW = ~A_seuil;

# on compte le nombre de pixels blancs
data = regionprops(BW,'Area');
hist([data.Area],100);
title("Distribution de la taille des grains de sable");

nb_grains = length(data);
printf('Nombre de grains de riz : %d\n', nb_grains);

mean_len = mean([data.Area]);
mean_len_2 = sum([data.Area])/nb_grains;
printf('Taille moyenne des grains de riz (fn): %d\n', mean_len);
printf('Taille moyenne des grains de riz (sum): %d\n', mean_len_2);

std_len = std([data.Area]);
std_len_2 = sqrt( sum( ([data.Area] - (mean_len_2)).^2 / (nb_grains - 1 )  ));
printf('Ecart type des grains de riz (fn): %d\n', std_len);
printf('Ecart type des grains de riz (sum): %d\n', std_len_2);

###########################################################################################
#### Question 2.b #########################################################################
###########################################################################################
close all;
nb_grains = size([data.Area],2);

densite = nb_grains / ( 79.83 * 41.95 );
printf('\nDensite des grains de sable (2) : %d\n', densite);

###########################################################################################
#### Question 2.c #########################################################################
###########################################################################################

aire_des_grains = sum([data.Area]);
aire_image = size(A,1) * size(A,2);

frac = aire_des_grains / aire_image;

printf('Fraction moyenne des grains de sable : %f\n', frac);

% surf_moy_occupe = mean_len * ( 79.83 * 41.95 ) / aire_image;
% frac = densite * surf_moy_occupe;

###########################################################################################
#### Question 3.a #########################################################################
###########################################################################################
close all;

P = @(lambda) (lambda.^nb_grains) / (factorial(nb_grains)) * exp(-lambda);

A_cercle = A_seuil(401:800,1051:1450);
imshow(~A_cercle);
data_cercle = regionprops(~A_cercle);

nb_grains_cercle = size([data_cercle.Area],2)
surface_pixel = ( 79.83 * 41.95 ) / ( size(A,1) * size(A,2) )

densite1 = nb_grains_cercle / ( size(A_cercle,1) * size(A_cercle,2) * surface_pixel );

printf("La densité des grains dans la nouvelle image est : %d\n",densite1)

###########################################################################################
#### Question 3.b #########################################################################
###########################################################################################
close all;

for k = 1:1000

    i = floor(rand * 378) + 1; 
    j = floor(rand * 378) + 1;

    data = regionprops(~A_cercle( i:i+20 , j:j+20 ));
    nb_grains(k) = size([data.Area],2);

end


###########################################################################################
#### Question 3.c #########################################################################
###########################################################################################


P = @(lambda,k) (lambda.^k) ./ (factorial(k)) .* exp(-lambda);

lambda = mean(nb_grains);
k = 0:max(nb_grains);

% P = (lambda.^k) ./ (factorial(k)) * exp(-lambda);

figure,
hold on;
bar(k,hist(nb_grains,max(nb_grains) +1) / numel(nb_grains) ,'FaceColor','b');
plot(k,P(lambda,k),'r','linewidth',2);
title("Distribution moyenne des grains de sable");
xlabel("Nombre de grains de sable");
ylabel("Probabilité");
legend("Distribution des grains de sable","Distribution de Poisson");

hold off;

###########################################################################################
#### Question 3.c #########################################################################
###########################################################################################
close all;

L = [20,22,24,26];
lambda = zeros(1,4);

figure,
for n = 1:4
for k = 1:1000

    i = floor(rand * 370) + 1; 
    j = floor(rand * 370) + 1;

    data = regionprops(~A_cercle( i:i+L(n) , j:j+L(n) ));
    nb_grains(k) = size([data.Area],2);

    end
    
    hold on;
    lambda(n) = mean(nb_grains);
    k = 0:max(nb_grains);

    bar(k,hist(nb_grains,max(nb_grains) +1) / numel(nb_grains));
    plot(k,P(lambda(n),k),'linewidth',2);
    title("Distribution moyenne des grains de sable");
end

hold off;


plot(L*surface_pixel,lambda,'linewidth',2);
title("Evolution de lambda en fonction de la taille de la fenetre");


% plot(L*surface_pixel,lambda,'linewidth',2);