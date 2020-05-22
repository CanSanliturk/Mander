function strain = StrainAfterUnloading(fC, fUN, epsUN, epsCC, Ec, fc0, ESec)

% Calculating plastic strain
epsP = GetPlasticStrainAfterLoading(fUN, epsUN, epsCC, Ec);

% Calculating Eu (unloading modulus)
b = max(fUN / fc0, 1);
c = min((epsCC / epsUN)^(0.5), 1);
Eu = b * c * Ec;

% Calculating r
r = Eu / (Eu - ESec);

% Calculating final strain
syms x;
eq = (fC - fUN) + ((fUN * x* r) / (r - 1 + (x^r)));
strain = (double(vpasolve(eq == 0, x)) * (epsP - epsUN)) + epsUN;
end