% Nettoie l'environnement de travail
clear all
close all
clc

% Définition des paramètres de base
N = 64; % Nombre de points
L = 1; % Longueur de l'intervalle
% Création d'un vecteur x linéairement espacé
x = linspace(-L, L, N)';

% Paramètre de fréquence
p = 10;
% Création du signal yp, une onde exponentielle complexe
yp = exp(2 * i * pi * p * x / 2 / L);
% Calcul de la transformation de Fourier (TF) du signal yp
tf_yp = fft(yp);

% Affichage des résultats
figure(1)
% Trace du signal yp dans le domaine spatial
subplot(2, 1, 1)
plot(x, yp)
% Trace de la magnitude de la TF de yp
subplot(2, 1, 2)
plot(abs(tf_yp))
