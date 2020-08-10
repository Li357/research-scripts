R.<X, Y, Z> = QQ[]

def print_ec(ec):
  print(f'CURVE: {ec.minimal_model()}\nRANK: {ec.analytic_rank()}\n')

# For m = 1, we have the two quartic curves
# Y^2 = X^4 - 6X^2 + 1
# Y^2 = X^4 + 2X^3 + 2X - 1

ec1_m1 = Jacobian(QuarticCurve(X^4 - 6*X^2*Z^2 + Z^4 - Y^2*Z^2))
print_ec(ec1_m1)

ec2_m1 = Jacobian(QuarticCurve(X^4 + 2*X^3*Z + 2*X*Z^3 - Z^4 - Y^2*Z^2))
print_ec(ec2_m1)

# For m = 3, we have the two quartic curves
# Y^2 = 4X^4 - 24X^2 + 4
# Y^2 = 2X^4 + 4X^3 + 4X - 2

ec1_m3 = Jacobian(QuarticCurve(4*X^4 - 24*X^2*Z^2 + 4*Z^4 - Y^2*Z^2))
print_ec(ec1_m3)

ec2_m3 = Jacobian(QuarticCurve(2*X^4 + 4*X^3*Z + 4*X*Z^3 - 2*Z^4 - Y^2*Z^2))
print_ec(ec2_m3)