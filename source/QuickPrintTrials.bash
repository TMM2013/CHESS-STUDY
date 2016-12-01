#!/bin/bash

Run=$1
DesignFile=/home/heffjos/Documents/EpisodicMemory/Design.csv

i=1
for Line in `grep -E ^${Run} ${DesignFile}`
do
    ImgName=`echo ${Line} | awk -F, '{print $5}'`
    ImgName=IMG${ImgName/.jpg/}
    ConditionName=`echo ${Line} | awk -F, '{print $2}'`
    TrialName=`printf Trial%04d ${i}`
    echo "<Trial>"
    echo "    <name>${TrialName}</name>"
    if [ ${ConditionName} == "NV" ]
    then
        echo "    <condition>1</condition>"
    else
        echo "    <condition>2</condition>"
    fi
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
