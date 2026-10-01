#!/usr/bin/env bash

# Zadatak:
# - pronaci sve .log fajlove
# 	-- za svaki izvrsiti wc -l sa {} \;
# 	-- tkaodjer i uraditi sa {} +
# - pronadji sve -txt fajlove
# 	-- pozovi basename 

# pronasao sam logove
find files -type f -name "*.log" -exec wc -l {} \; 

#sada isto sve samo kulmunalno
find files -type f -name "*.log" -exec wc -l {} + | tail -n 1 
