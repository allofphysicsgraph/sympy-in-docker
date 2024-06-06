git clone https://github.com/antlr/grammars-v4
cp -r grammars-v4/arithmetic/examples . 
for i in $(ls examples/|grep txt$|shuf ); 
	do 
		echo examples/$i; 
		cat examples/$i;
		bash gui.sh examples/$i;
	done
