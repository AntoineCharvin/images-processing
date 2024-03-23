% Nettoyage de l'environnement de travail
clear all
close all
clc

% Lecture du fichier audio
[son, fs] = audioread('Mahler_Adagietto_Symphony_5_extrait.flac');
% Création d'un lecteur audio pour le son (commenté)
% player = audioplayer(son, fs);
% Lecture du son (commenté)
% play(player);

% Combinaison des canaux stéréo en un signal mono
signal = son(:, 1) + son(:, 2);

% Transformation de Fourier du signal
tf_signal = fft(signal);
% Affichage des dimensions du signal et de sa transformation de Fourier
size(signal)
size(tf_signal)
% Définition de l'intervalle de temps
dt = 1 / fs;
% Création d'un vecteur de temps pour le signal
temps = dt * [0:size(signal, 1) - 1];
% Tracé du signal dans le temps
plot(temps, signal)
% Calcul des fréquences correspondantes à la transformation de Fourier
frequence = 44100 / size(signal, 1) * [0:size(signal, 1) - 1];

% Affichage des parties réelle et imaginaire de la transformation de Fourier
figure, 
subplot(2, 1, 1)
plot(frequence, real(tf_signal))
subplot(2, 1, 2)
plot(frequence, imag(tf_signal))

% Affichage du spectre de puissance pour les fréquences jusqu'à 1200 Hz
figure, plot(frequence(1:floor(1200 * size(signal, 1) / 44100)), abs(tf_signal(1:floor(1200 * size(signal, 1) / 44100)).^2))
