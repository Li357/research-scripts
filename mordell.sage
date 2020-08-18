# spaghetti galore

from sage.schemes.elliptic_curves.weierstrass_morphism import *

R.<X, Y, Z> = QQ[]

# quartic -> cubic (Y -> Y + X^2)
# Y^2 = X^4 - 6*X^2 + 1 -> Y^2 + 2*X^2*Y = -6*X^2 + 1

cubic1 = -6*X^2*Z + Z^3 - Y^2*Z - 2*X^2*Y
f1 = EllipticCurve_from_cubic(cubic1, [0, 1, 1], morphism=True)
E1 = f1.codomain()

E1min = E1.minimal_model()
u, r, s, _t = E1.isomorphism_to(E1min).tuple()

E1minToE = lambda x, y: [u^2*x + r, u^3*y + s*u^2*x + _t]

cubic2 = 2*X^3 + 2*X*Z^2 - Z^3 - 2*X^2*Y - Y^2*Z
f2 = EllipticCurve_from_cubic(cubic2, [1, 1, 1], morphism=True)
E2 = f2.codomain()

E2min = E2.minimal_model()
# u, r, s, t = E1min.isomorphism_to(E).tuple()

E1p = E1min.integral_points()
E2p = E2min.integral_points()

_, _1wa2, _, _1wa4, _1wa6 = E1min.ainvs()
_, _2wa2, _, _2wa4, _2wa6 = E2min.ainvs()

a1, b1, P1, Q1, a2, b2, P2, Q2 = var('a1, b1, P1, Q1, a2, b2, P2, Q2', domain='real')
z = var('z')
assume(b1, 'rational')
assume(b2, 'rational')

# finds quadratic solutions to x^4 + y^4 = 2
for p1 in E1p:
  for p2 in E2p:
    x1, y1 = p1.xy()
    x2, y2 = p2.xy()
    _a1, _P1 = solve([a1+b1*x1 == y1, P1+Q1*x1 == 0], a1, P1)[0]
    _a2, _P2 = solve([a2+b2*x2 == y2, P2+Q2*x2 == 0], a2, P2)[0]

    d1 = z if _P1 == 0 else z - x1
    d2 = z if _P2 == 0 else z - x2

    F1 = (((_a1 + b1*z)^2 - (z^3 + _1wa2*z^2 + _1wa4*z + _1wa6)) / d1).full_simplify().rhs()
    F2 = (((_a2 + b2*z)^2 - (z^3 + _2wa2*z^2 + _2wa4*z + _2wa6)) / d2).full_simplify().rhs()

    F1_coeffs = F1.coefficients(z, sparse=0)
    _Q1 = F1_coeffs[-1]
    F2_coeffs = F2.coefficients(z, sparse=0)
    _Q2 = F2_coeffs[-1]

    assume(b1, b2, 'rational')
    sln_set = solve([eq1 == eq2 for eq1, eq2 in zip(F1_coeffs, F2_coeffs)], b1, b2)
    if len(sln_set) > 0:
      _b1, _b2 = map(lambda e: e.rhs(), sln_set[0])
      if _b1 in QQ and _b2 in QQ: # since assumptions don't work for some reason
        __a1, __P1 = solve([a1+_b1*x1 == y1, P1+_Q1*x1 == 0], a1, P1)[0]
        __a2, __P2 = solve([a2+_b2*x2 == y2, P2+_Q2*x2 == 0], a2, P2)[0]
        _F = (((__a1 + _b1*z)^2 - (z^3 + _1wa2*z^2 + _1wa4*z + _1wa6)) / d1).full_simplify().rhs()

        t = solve([_F == 0], z)[0].rhs()
        x, y = E1minToE(t, __a1.rhs()+_b1*t)
        
        _X, _Y, _Z = map(lambda p: p([x, y, 1]), f1.inverse().defining_polynomials())
        __X = (_X / _Z).full_simplify()
        #__Y = (_Y / _Z).full_simplify()

        #___Y = __Y + __X^2
        #__t = solve([__X == ])

        sol_x2 = (((__X)^2 - 2*(__X) - 1)/(__X^2 + 1)).full_simplify()
        sol_y2 = (((__X)^2 + 2*(__X) - 1)/(__X^2 + 1)).full_simplify()

        sol_x = sqrt(sol_x2).full_simplify()
        sol_y = sqrt(sol_y2).full_simplify()

        print(f'F(z) = {_F}\nt = {t}, a1 = {__a1.rhs()}, b1 = {_b1}\nx1 = {x}, y1 = {y}\nt = {__X}\n(x, y) = {(sol_x, sol_y)}\n(x^2, y^2) = {(sol_x2, sol_y2)}')
