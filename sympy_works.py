#!/usr/bin/env python3

"""
example of pure SymPy (no Latex)

from https://docs.sympy.org/latest/tutorials/intro-tutorial/intro.html
"""

import sympy
print("sympy:",sympy.__version__)

x, y = sympy.symbols('x y')
expr = x + 2*y

print(type(expr))
print(expr)
