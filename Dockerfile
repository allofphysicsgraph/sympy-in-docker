FROM ubuntu:23.04

WORKDIR /opt/

RUN apt -y update && apt upgrade
RUN apt install -y python3 python3-pip pipx

# With pipx when you install things they go into isolated environments. With pip you're just installing things globally.

# https://pypa.github.io/pipx/comparisons/

# https://pypa.github.io/pipx/installation/
#RUN python3 -m pip install --user pipx

# https://pypi.org/project/sympy/
# the following works but then sympy isn't available for import
RUN pipx install sympy

RUN apt install -y python3-sympy
