#!/usr/bin/env python3

"""
docker run -it --rm -v `pwd`:/scratch --workdir /scratch sympyonubuntu python3 eval_latex.py ../latex-example-expressions/examples_of_valid_latex/expression_010.tex

"""
import sys

import sympy
print("sympy:",sympy.__version__)

from sympy.parsing.latex import parse_latex

if len(sys.argv)!=2:
	print("Requires 1 argument: path to .tex file")
	exit()
else:
	path_to_tex_file = sys.argv[1]

print("path_to_tex_file=",path_to_tex_file)

with open(path_to_tex_file,"r") as file_handle:
	file_content = file_handle.read()

file_content =file_content.replace("\\begin{equation}","").replace("\\end{equation}","").strip()

print("raw Latex:\n",file_content,"\n")

expr = parse_latex(file_content)
print("type:",type(expr))
print("parses to\n\\begin{verbatim}")
print(expr)
print("\\end{verbatim}\nwith atoms $"+str(expr.atoms())+"$\\\\")
print("using antlr4-python3-runtime==4.11 and sympy==1.12")