path='latex-example-expressions/examples_of_valid_latex'
file_name=$(ls $path|grep tex$|shuf|grep -v main|grep clean|sed -n 1p)
cp $path/$file_name .
cat $file_name
bash gui.sh $file_name
