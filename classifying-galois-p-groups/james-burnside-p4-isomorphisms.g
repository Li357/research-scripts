GroupFromPresentation := function (gens, eqnClosure)
  local group, fgGens, gen;
  group := CallFuncList(FreeGroup, gens);
  fgGens := [group.1^0];
  for gen in gens do
    Add(fgGens, group.(Length(fgGens)));
  od;
  return group / CallFuncList(eqnClosure, fgGens);
end;

IsIsomorphicGroup := {G, H} -> IsomorphismGroups(G, H) <> fail;

p := 3;
ix := GroupFromPresentation(["P", "Q", "R"], {e, P, Q, R} -> [
  [P^(p^2), e],
  [Q^(p^2), e],
  [R^p, e],
  [R^(-1) * P * R, P^(1+p)],
  [P^(-1) * Q * P, Q],
  [R^(-1) * Q * R, Q]
]);

phi2_21 := GroupFromPresentation(["a", "a1", "a2"], {e, a, a1, a2} -> [
  [Comm(a1, a), a2],
  [a^p, a2],
  [a1^p, e],
  [a2^p, e],
  [Comm(a, a2), e]
]);
phi2_211a := DirectProduct(phi2_21, CyclicGroup(p));