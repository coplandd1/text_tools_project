#!/bin/bash

DOOFILE=$(ls *.txt)
WAYFILE=$(ls WAY_*.txt)
WNFILE=$(ls WN_*.txt)
MIFILE=$(ls MI_*.txt)
DOONAME=$(ls $1 | sed 's/\.txt//g') 

#gets wc of Scooby's dialogue per episode
doocount(){
cat $1 | grep -i "Scooby:" \
	| sed "s/[^:]*://" \
	| tr -d '[.\,\:\!_\;?\"\`]' \
	| wc -w
}

#gets wc of ALL dialogue per episode
epcount(){
cat $1 | sed "s/[^:]*://" \
	| tr -d '[.\,\:\!_\;?\"\`]' \
	| wc -w
}

#gets Scooby's type count per episode
dootype(){
cat $1 | grep -i "Scooby:" \
	| sed "s/[^:]*://" \
	| tr 'A-Z' 'a-z' \
	| tr -d '[.\,\:\!_\;?\"\`]' \
	| tr -s ' ' '\n' \
	| grep '\S' \
	| sort -u \
	| wc -l
}

#gets linecount of Scooby's dialogue per episode
dooline(){
cat $1 | grep -i "Scooby:" \
	| sed "s/[^:]*://" \
	| tr "[.!?]" "\n" \
	| grep '\S' \
	| wc -l
}


#calculates values for Where Are You
for file in $WAYFILE; do

	WAYWC=$(doocount "$file")
	WAYEP=$(epcount "$file")
	WAYTYPE=$(dootype "$file")
	WAYLINE=$(dooline "$file")

	WAYPEREP=$(awk -v WAYWC=$WAYWC -v WAYEP=$WAYEP 'BEGIN { print WAYWC / WAYEP }')
	WAYMLU=$(awk -v WAYLINE=$WAYLINE -v WAYWC=$WAYWC 'BEGIN { print WAYLINE / WAYWC }')
	WAYRATIO=$(awk -v WAYTYPE=$WAYTYPE -v WAYWC=$WAYWC 'BEGIN { print WAYTYPE / WAYWC }')

	echo $WAYPEREP >> WAY_dialogue.txt
	echo $WAYMLU >> WAY_MLU.txt
	echo $WAYRATIO >> WAY_ratio.txt
done

	WAYFINALD=$(awk '{ total += $1 } END { print total/NR }' WAY_dialogue.txt)
	WAYFINALM=$(awk '{ total += $1 } END { print total/NR }' WAY_MLU.txt)
	WAYFINALR=$(awk '{ total += $1 } END { print total/NR }' WAY_ratio.txt)


	echo "Where Are You Averages:
	$WAYFINALD ratio Scooby dialogue per episode
	$WAYFINALM Mean Length of Utterance
	$WAYFINALR Type/Token ratio"

	rm WAY_dialogue.txt
	rm WAY_MLU.txt
	rm WAY_ratio.txt
	



#calculates values for What's New
for file in $WNFILE; do

	WNWC=$(doocount "$file")
	WNEP=$(epcount "$file")
	WNTYPE=$(dootype "$file")
	WNLINE=$(dooline "$file")

	WNPEREP=$(awk -v WNWC=$WNWC -v WNEP=$WNEP 'BEGIN { print WNWC / WNEP }')
	WNMLU=$(awk -v WNLINE=$WNLINE -v WNWC=$WNWC 'BEGIN { print WNLINE / WNWC }')
	WNRATIO=$(awk -v WNTYPE=$WNTYPE -v WNWC=$WNWC 'BEGIN { print WNTYPE / WNWC }')

	echo $WNPEREP >> WN_dialogue.txt
	echo $WNMLU >> WN_MLU.txt
	echo $WNRATIO >> WN_ratio.txt
done

	WNFINALD=$(awk '{ total += $1 } END { print total/NR }' WN_dialogue.txt)
	WNFINALM=$(awk '{ total += $1 } END { print total/NR }' WN_MLU.txt)
	WNFINALR=$(awk '{ total += $1 } END { print total/NR }' WN_ratio.txt)


	echo "What's New Averages:
	$WNFINALD ratio Scooby dialogue per episode
	$WNFINALM Mean Length of Utterance
	$WNFINALR Type/Token ratio"

	rm WN_dialogue.txt
	rm WN_MLU.txt
	rm WN_ratio.txt



#calculates values for Mystery Inc
for file in $MIFILE; do

	MIWC=$(doocount "$file")
	MIEP=$(epcount "$file")
	MITYPE=$(dootype "$file")
	MILINE=$(dooline "$file")

	MIPEREP=$(awk -v MIWC=$MIWC -v MIEP=$MIEP 'BEGIN { print MIWC / MIEP }')
	MIMLU=$(awk -v MILINE=$MILINE -v MIWC=$MIWC 'BEGIN { print MILINE / MIWC }')
	MIRATIO=$(awk -v MITYPE=$MITYPE -v MIWC=$MIWC 'BEGIN { print MITYPE / MIWC }')

	echo $MIPEREP >> MI_dialogue.txt
	echo $MIMLU >> MI_MLU.txt
	echo $MIRATIO >> MI_ratio.txt
done

	MIFINALD=$(awk '{ total += $1 } END { print total/NR }' MI_dialogue.txt)
	MIFINALM=$(awk '{ total += $1 } END { print total/NR }' MI_MLU.txt)
	MIFINALR=$(awk '{ total += $1 } END { print total/NR }' MI_ratio.txt)
	
	echo "Mystery Inc. Averages:
	$MIFINALD ratio Scooby dialogue per episode
	$MIFINALM Mean Length of Utterance
	$MIFINALR Type/Token ratio"

	rm MI_dialogue.txt
	rm MI_MLU.txt
	rm MI_ratio.txt




