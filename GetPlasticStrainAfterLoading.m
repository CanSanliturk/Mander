function epsP = GetPlasticStrainAfterLoading(fUN, epsUN, epsCC, Ec)

% Obtaining epsAlpha
alpha = max(epsCC/(epsCC + epsUN), 0.09 * epsUN / epsCC);
epsAlpha = alpha * sqrt(epsCC * epsUN); 

% Calculating plastic strain
epsP = epsUN - ((fUN * (epsUN + epsAlpha)) / (fUN + (Ec * epsAlpha)));

end