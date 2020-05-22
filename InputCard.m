clear;
clc;

% INPUT CARD
fc = 30; % Initially aplied stress in MPa
fSec = 10; % Stress after first unloading in MPa
fc0 = 40; % Unconfined concrete strength in MPa
epsC0 = 0.002; % Ultimate strain capacity of unconfined concrete
k1 = 4.1; % According to Richart et al (1928) (k2 is found accordingly)
f1 = 0; % Confining lateral stress in MPa (0 for unconfined case)


% After completing input card, executing this script will be enough
CompSol(fc, fSec, fc0, epsC0, k1, f1);