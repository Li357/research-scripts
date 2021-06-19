from sympy import sieve
import requests

primes = sieve.primerange(1, 1000)

for prime in primes:
  if prime % 8 == 1:
    req = requests.get(f'https://www.lmfdb.org/api/ec_curves/?_format=json&_fields=rank&jinv=1728&ainvs=li0;0;0;{prime};0&_delim=;')
    json = req.json()
    if 'data' in json and len(json['data']) > 0:
      rank = json['data'][0]['rank']
      print(f'p = {prime}, rank = {rank}')