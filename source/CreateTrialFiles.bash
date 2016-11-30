#!/bin/bash

for i in 1 2 3 4
do
    ./QuickPrintTrials.bash ${i} > RunList${i}.txt
done
