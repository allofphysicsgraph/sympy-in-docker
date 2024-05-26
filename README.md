# SymPy in Docker

Assuming your have `docker` (or, after some editing, `podman`) and `make` installed, to build this container run
```bash
make
```

Once the container exists, Python3 and SymPy are available
```bash
$ docker run -it --rm sympyonubuntu python3 -c 'import sympy; print(sympy.__version__)'
1.12

$ docker run -it --rm sympyonubuntu python3 -c 'import sys; print(sys.version)'
3.8.10 (default, Nov 22 2023, 10:22:35) 
```

Run a script
```bash
$ docker run -it --rm -v `pwd`:/scratch --workdir /scratch sympyonubuntu python3 sympy_works.py 
sympy: 1.12
<class 'sympy.core.add.Add'>
x + 2*y 
```

```bash
docker run -it --rm sympyonubuntu python3 -c 'import sys; print(sys.version); import sympy; print("sympy:",sympy.__version__); from sympy.parsing.latex import parse_latex; x = parse_latex("a = b"); print(type(x)); print(x)'
3.8.10 (default, Nov 22 2023, 10:22:35) 
[GCC 9.4.0]
sympy: 1.12
<class 'sympy.core.relational.Equality'>
Eq(a, b)
```

Assuming you've copied `examples_of_valid_latex` into the local directory,
```bash
for filename in examples_of_valid_latex/expr*.tex; do 
  docker run -it --rm -v `pwd`:/scratch --workdir /scratch sympyonubuntu python3 eval_latex.py $filename
done
```
That folder is found in <https://github.com/allofphysicsgraph/latex-example-expressions/tree/master/examples_of_valid_latex>


