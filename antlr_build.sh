
curl -O https://www.antlr.org/download/antlr-4.13.1-complete.jar
sudo cp antlr-4.13.1-complete.jar /usr/local/lib/

export CLASSPATH=".:/usr/local/lib/antlr-4.13.1-complete.jar:$CLASSPATH"

#java -jar /usr/local/lib/antlr-4.13.1-complete.jar LaTeX.g4 -no-visitor -no-listener -o _antlr
#python rename.py
#cd ../../../
#python setup.py install
