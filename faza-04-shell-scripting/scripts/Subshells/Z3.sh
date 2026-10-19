#!/usr/bin/env bash

# Zadatak - napraviti simulaciju da se vidi razlika izmedju grupe i subshella 
# hajde prvo grupa

a="1"
b="2"

{ echo $a; echo $b; } > f
cat < f
(echo a; echo b ) > f
cat < f

# nisam ga dobro napisao ali sam shvatio caku

# -- fazon je da varijable postoje i da ih subshell uzme, medjutim izlaskom ne poprima promjene nego original ostaje

