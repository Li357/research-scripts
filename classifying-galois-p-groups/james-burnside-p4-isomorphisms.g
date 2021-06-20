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

p := 5;
xv := GroupFromPresentation(["P", "Q", "R", "S"], {e, P, Q, R, S} -> [
  [P^p, e],
  [Q^p, e],
  [R^p, e],
  [S^p, e],
  [Comm(R, S), Q],
  [Comm(Q, S), P],
  [Comm(P, S), e],
  [Comm(Q, R), e],
  [Comm(P, R), e],
  [Comm(P, Q), e]
]);

phi3_1111 := GroupFromPresentation(["a", "a1", "a2", "a3"], {e, a, a1, a2, a3} -> [
  [Comm(a1, a), a2],
  [Comm(a2, a), a3],
  [a^p, e],
  [a3^p, e],
  [a1^p * a2^(Binomial(p, 2)) * a3^(Binomial(p, 3)), e],
  [a2^p * a3^(Binomial(p, 3)), e],
  [Comm(a, a3), e],
  [Comm(a1, a2), e],
  [Comm(a1, a3), e],
  [Comm(a2, a3), e]
]);

IsIsomorphicGroup(xv, phi3_1111);