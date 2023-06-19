# Lean in Docker

Assuming your have `docker` (or `podman`) and `make` installed, to build this container run
```bash
make
```

Once the container exists, Python3 and SymPy are available
```bash
$ docker run -it --rm sympyonubuntu python3 -c 'import sympy; print(sympy.__version__)'
1.11.1

$ docker run -it --rm sympyonubuntu python3 -c 'import sys; print(sys.version)'
3.11.2 (main, May 30 2023, 17:45:26) [GCC 12.2.0]
```

Run a script
```bash
$ docker run -it --rm -v `pwd`:/scratch --workdir /scratch sympyonubuntu python3 expression_example.py 
x + 2*y
```

