function epsRe = GetStrainAtParabolicReloading(epsUn, fUn, f, Er, fCC, fC0)

epsRe = epsUn + ((fUn - f) / (Er * (2 + (fCC / fC0))));

end