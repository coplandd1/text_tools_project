#!/bin/bash

WAYfile=$(ls WAY_*.txt)
WNfile=$(ls WN_*.txt)
MIfile=$(ls MI_*.txt)
ROOBYdat=$(ls roobydata.csv)
wayclean(){
	cat $1 | sed '/[A-z]/!d' \
	| sed -e 's/\[.*\][[:space:]]*//g' -e 's/<.*>[[:space:]]*/ /g' \
	| sed -e '/^\?/d' -e '/♪/d' \
	| grep -Ev ' \?' \
	| grep '\S' > /home/thede/text_tools_project/cleandata/"$1"
}
wnclean(){
	cat $1 | sed '/[A-z]/!d' \
	| sed -e 's/\[.*\][[:space:]]*//g' -e 's/(.*)[[:space:]]*/ /g' \
	| sed -e '/^\*/d' -e '/♪/d' \
	| grep -Ev ' \*' \
	| grep '\S' > /home/thede/text_tools_project/cleandata/"$1"

}
miclean(){
	cat $1 | sed '/[A-z]/!d' \
	| sed -e 's/\[.*\][[:space:]]*//g' -e 's/(.*)[[:space:]]*/ /g' \
	| grep -v 'INT\..*$' \
	| grep -v 'EXT\..*$' \
	| grep -v 'SCENE:.*$' \
	| grep '\S' > /home/thede/text_tools_project/cleandata/"$1"
}


for file in $WAYfile; do 
	
	wayclean "$file"

done


for file in $WNfile; do

	wnclean "$file"

done

for file in $MIfile; do

	miclean "$file"
done

