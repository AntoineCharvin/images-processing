% Nettoie l'environnement de travail
clear all
close all
clc

% Lecture d'un fichier audio FLAC
[son, fs] = audioread("Mahler_Adagietto_Symphony_5_extrait.flac");
% Création d'un objet audioplayer pour jouer le son (commenté)
% player = audioplayer(son, fs);
% Lecture du son (commenté)
% play(player);

% Combinaison des deux canaux stéréo en un seul signal
Signal = son(:, 1) + son(:, 2);
% Affichage du signal audio combiné
plot(Signal)
