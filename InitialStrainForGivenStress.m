function strain = InitialStrainForGivenStress(fcc, fc, epsCC, Ec, ESec)

syms x;
r = Ec / (Ec - ESec);
eq = fc - ((fcc * r * x) / (r - 1 + (x^r)));
strain = double(vpasolve(eq == 0, x)) * epsCC;
end