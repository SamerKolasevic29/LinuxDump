#!/urs/bin/env bash

# Zadatak - uraditi sort <(command1) i command1 | sort
# vidjeti razliku



echo " --- sa ProccesSubom ---"
sort <(ls /home/SAMER/Projects/githab)


echo " ---  sa pipe-om --- "
ls /home/SAMER/Projects/githab | sort
