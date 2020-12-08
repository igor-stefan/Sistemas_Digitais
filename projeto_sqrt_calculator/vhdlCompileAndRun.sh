#! /bin/bash

FILENAME=$1
FILENAME2=$2

ghdl -s ${FILENAME} ${FILENAME2} \
&& ghdl -a ${FILENAME} ${FILENAME2} \
&& ghdl -e testbench \
&& ghdl -r testbench --vcd=test.vcd \
&& gtkwave test.vcd
