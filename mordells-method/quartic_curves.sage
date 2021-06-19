# For m = 1, we have the two quartic curves
# Y^2 = X^4 - 6X^2 + 1
# Y^2 = X^4 + 2X^3 + 2X - 1
#
# For m = 3, we have the two quartic curves
# Y^2 = 4X^4 - 24X^2 + 4
# Y^2 = 2X^4 + 4X^3 + 4X - 2

R.<X, Y, Z> = QQ[]
curves = [
  X^4 - 6*X^2*Z^2 + Z^4 - Y^2*Z^2,
  X^4 + 2*X^3*Z + 2*X*Z^3 - Z^4 - Y^2*Z^2,
  4*X^4 - 24*X^2*Z^2 + 4*Z^4 - Y^2*Z^2,
  2*X^4 + 4*X^3*Z + 4*X*Z^3 - 2*Z^4 - Y^2*Z^2,
]

for curve in curves:
  E = Jacobian(QuarticCurve(curve))
  rank = E.analytic_rank()
  Emin = E.minimal_model()

  finv = Jacobian(QuarticCurve(curve), morphism=True).inverse()
  print(finv.defining_polynomials())

def print_ec(ec):
  print(f'CURVE: {ec.minimal_model()}\nRANK: {ec.analytic_rank()}\n')