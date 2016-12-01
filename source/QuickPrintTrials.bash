#!/bin/bash

Run=$1
DesignFile=/home/heffjos/Documents/EpisodicMemory/Design.csv

i=1
for Line in `grep -E ^${Run} ${DesignFile}`
do
    ImgName=`echo ${Line} | awk -F, '{print $5}'`
    ImgName=IMG${ImgName/.jpg/}
    TrialName=`printf Trial%04d ${i}`
    echo "<Trial>"
    echo "    <name>${TrialName}</name>"
    echo "    <condition>1</condition>"
    echo "    <show>"
    echo "        <item>${ImgName}</item>"
    echo "    </show>"
    echo "    <show>"
    echo "        <item>NoImg</item>"
    echo "    </show>"
    echo "</Trial>"
    echo
    ((i++))
done
