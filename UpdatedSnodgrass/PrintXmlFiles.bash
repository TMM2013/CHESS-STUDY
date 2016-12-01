#!/bin/bash

for oneFile in *jpg
do
    # let's skip position right now
    output=${oneFile/.jpg/}
    echo "<Slide>"
    echo "    <name>IMG${output}</name>"
    echo "    <condition>1</condition>"
    # make sure path below is correct
    echo "    <Picture>../../UpdatedSnodgrass/${oneFile}</Picture>"
    echo "    <duration>2500</duration>"
    echo "    <expectedResponse>"
    echo "        <key>C</key>"
    echo "        <count>1</count>"
    echo "    </expectedResponse>"
    echo "</Slide>"
    echo 
done

