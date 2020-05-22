function Er = GetReloadingTangentModulus(f, fRo, epsRo, epsUn)

Er = (fRo - f) / (epsRo - epsUn);

end