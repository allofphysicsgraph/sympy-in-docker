IMAGE_NAME=sympyonubuntu

docker: docker_build docker_run

docker_build:
	docker build -t $(IMAGE_NAME) .

docker_run:
	docker run -it --rm \
             -v `pwd`:/scratch \
	     --workdir /scratch \
             --user $(id -u):$(id -g) \
             $(IMAGE_NAME) /bin/bash 

example_latex_expressions:
	git clone https://github.com/allofphysicsgraph/latex-example-expressions

grammarinator:
	apt install git
	git clone https://github.com/renatahodovan/grammarinator
