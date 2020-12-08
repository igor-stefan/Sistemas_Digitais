#!/bin/bash

FILENAME=$1
g++ ${FILENAME} -std=c++11 -Wextra -Wpedantic -Wall -o a && ./a < input.txt
