#!/bin/bash

WAYFILE=$(ls WAY_*.txt)
WNFILE=$(ls WN_*.txt)
MIFILE=$(ls MI_*.txt)

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

	rm Where_*.txt
	rm What_*.txt
	rm Mys_*.txt

#calculates values for Where Are You
for file in $WAYFILE; do

	WAYWC=$(doocount "$file")
	WAYEP=$(epcount "$file")
	WAYTYPE=$(dootype "$file")
	WAYLINE=$(dooline "$file")

	WAYPEREP=$(awk -v WAYWC=$WAYWC -v WAYEP=$WAYEP 'BEGIN { print WAYWC / WAYEP }')
	WAYMLU=$(awk -v WAYLINE=$WAYLINE -v WAYWC=$WAYWC 'BEGIN { print WAYLINE / WAYWC }')
	WAYRATIO=$(awk -v WAYTYPE=$WAYTYPE -v WAYWC=$WAYWC 'BEGIN { print WAYTYPE / WAYWC }')

	echo $WAYPEREP >> Where_dialogue.txt
	echo $WAYMLU >> Where_MLU.txt
	echo $WAYRATIO >> Where_ratio.txt
done

	WAYFINALD=$(awk '{ total += $1 } END { print total/NR }' Where_dialogue.txt)
	WAYFINALM=$(awk '{ total += $1 } END { print total/NR }' Where_MLU.txt)
	WAYFINALR=$(awk '{ total += $1 } END { print total/NR }' Where_ratio.txt)


	echo "Where Are You Averages:
	$WAYFINALD ratio Scooby dialogue per episode
	$WAYFINALM Mean Length of Utterance
	$WAYFINALR Type/Token ratio"


#calculates values for What's New
for file in $WNFILE; do

	WNWC=$(doocount "$file")
	WNEP=$(epcount "$file")
	WNTYPE=$(dootype "$file")
	WNLINE=$(dooline "$file")

	WNPEREP=$(awk -v WNWC=$WNWC -v WNEP=$WNEP 'BEGIN { print WNWC / WNEP }')
	WNMLU=$(awk -v WNLINE=$WNLINE -v WNWC=$WNWC 'BEGIN { print WNLINE / WNWC }')
	WNRATIO=$(awk -v WNTYPE=$WNTYPE -v WNWC=$WNWC 'BEGIN { print WNTYPE / WNWC }')

	echo $WNPEREP >> What_dialogue.txt
	echo $WNMLU >> What_MLU.txt
	echo $WNRATIO >> What_ratio.txt
done

	WNFINALD=$(awk '{ total += $1 } END { print total/NR }' What_dialogue.txt)
	WNFINALM=$(awk '{ total += $1 } END { print total/NR }' What_MLU.txt)
	WNFINALR=$(awk '{ total += $1 } END { print total/NR }' What_ratio.txt)


	echo "What's New Averages:
	$WNFINALD ratio Scooby dialogue per episode
	$WNFINALM Mean Length of Utterance
	$WNFINALR Type/Token ratio"



#calculates values for Mystery Inc
for file in $MIFILE; do

	MIWC=$(doocount "$file")
	MIEP=$(epcount "$file")
	MITYPE=$(dootype "$file")
	MILINE=$(dooline "$file")

	MIPEREP=$(awk -v MIWC=$MIWC -v MIEP=$MIEP 'BEGIN { print MIWC / MIEP }')
	MIMLU=$(awk -v MILINE=$MILINE -v MIWC=$MIWC 'BEGIN { print MILINE / MIWC }')
	MIRATIO=$(awk -v MITYPE=$MITYPE -v MIWC=$MIWC 'BEGIN { print MITYPE / MIWC }')

	echo $MIPEREP >> Mys_dialogue.txt
	echo $MIMLU >> Mys_MLU.txt
	echo $MIRATIO >> Mys_ratio.txt
done

	MIFINALD=$(awk '{ total += $1 } END { print total/NR }' Mys_dialogue.txt)
	MIFINALM=$(awk '{ total += $1 } END { print total/NR }' Mys_MLU.txt)
	MIFINALR=$(awk '{ total += $1 } END { print total/NR }' Mys_ratio.txt)
	
	echo "Mystery Inc. Averages:
	$MIFINALD ratio Scooby dialogue per episode
	$MIFINALM Mean Length of Utterance
	$MIFINALR Type/Token ratio"





