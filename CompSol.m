function Compsol(fc, fSec, fc0, epsC0, k1, f1)
% Derivated parameters
k2 = 5 * k1; % According to Richart et al (1928)
fcc = fc0 + (k1 * f1); % Concrete strength in MPa including confinement
epsCC = epsC0 * (1 + (k2 * (f1 /fc0))); % Ultimate strain capacity of confined conrete
Ec = 5000 * sqrt(fc); % Initial modulus in MPa
ESec = fcc / epsCC; % Secant modulus in MPa

% Initial strain
j = 0;
for i = 0:1:fc
    j = j + 1;
    epsIni = InitialStrainForGivenStress(fcc, i, epsCC, Ec, ESec);
    epsList(i + 1) = epsIni;
    sigList(i + 1) = i;
end

epsUN = epsList(j);
fUN = sigList(j);

% Strain at the end of unloading up to 10 MPa
for i = (fc - 1):-1:fSec
% (fC, fUN, epsUN, epsCC, Ec, fc0, ESec)
    j = j + 1;  
    epsList(j) = StrainAfterUnloading(i, fUN, epsUN, epsCC, Ec, fc0, ESec);
    sigList(j) = i;
    fRo = i;
    epsRo = epsList(j);
end

epsRo = epsList(j);
fRo = sigList(j);

% Strain at the end of reloading up to 35 MPa
%   Linear portion
j = j + 1;
epsList(j) = epsUN;
sigList(j) = (0.92 * fUN) + (0.08 * fRo);

sigLinearLast = sigList(j);
epsUN = epsList(j);

%   Parabolic portion
% Parabolic function is skipped, strain at the end of the reloading is 
% directly found
j = j + 1;
Er = GetReloadingTangentModulus(sigLinearLast, fRo, epsRo, epsUN);
epsRe = epsUN + ((fUN - sigLinearLast) / (Er * (2 + (fcc / fc0))));
epsList(j) = epsRe;
sigList(j) = fc;

epsUN = epsList(j);
fUN = sigList(j);

% Final unloading
for i = (fc - 1):-1:0
% (fC, fUN, epsUN, epsCC, Ec, fc0, ESec)
    j = j + 1;  
    epsList(j) = StrainAfterUnloading(i, fUN, epsUN, epsCC, Ec, fc0, ESec);
    sigList(j) = i;
    fRo = i;
    epsRo = epsList(j);
end

figure(1);
plot(epsList, sigList);
title('Mander Conrete Model For Cyclic Loading')
xlabel('Strain')
ylabel('Stress (MPa)')
ylim([0, fcc]);

hold off;

end
