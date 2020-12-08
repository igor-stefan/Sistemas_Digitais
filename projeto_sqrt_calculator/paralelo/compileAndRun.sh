#!/bin/sh

find ~/Desktop/vhdl_try/projeto_sqrt_calculator/paralelo"$1"/ -type f -name '*.vhd' -print0 | while read -d $'\0' file
do
   echo "$file" &&
   ghdl -s $file &&
   ghdl -a $file
done
ghdl -e testbench &&
ghdl -r testbench --vcd=first.vcd &&
gtkwave first.vcd
