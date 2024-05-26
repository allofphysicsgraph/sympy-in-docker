# Physics Derivation Graph
# Ben Payne, 2024
# https://creativecommons.org/licenses/by/4.0/
# Attribution 4.0 International (CC BY 4.0)


# https://docs.docker.com/engine/reference/builder/#from
# https://github.com/phusion/baseimage-docker
FROM phusion/baseimage:focal-1.1.0


WORKDIR /opt/

#RUN apt -y update && apt -y upgrade
RUN apt -y update
RUN apt install -y python3 python3-pip 

# With pipx when you install things they go into isolated environments. With pip you're just installing things globally.

# https://pypa.github.io/pipx/comparisons/

# https://pypa.github.io/pipx/installation/
#RUN python3 -m pip install --user pipx

# https://pypi.org/project/sympy/
# the following works but then sympy isn't available for import
#RUN pipx install sympy

# necessary for the command "sympy.srepr(parse_latex('f(x)'))"
RUN pip install antlr4-python3-runtime==4.11 sympy


