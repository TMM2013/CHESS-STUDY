#!/bin/bash

Counter=1
while [[ $Counter -lt 95 ]]
do
    Trial=`printf Trial%04d ${Counter}`
    echo "<runtrial>${Trial}</runtrial>"
    ((Counter++))
done
