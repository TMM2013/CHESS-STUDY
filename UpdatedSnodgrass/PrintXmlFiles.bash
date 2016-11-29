#!/bin/bash

for oneFile in *jpg
do
    output=${oneFile/.jpg/}
    echo "<name>${output}</name>"
    echo "<Picture>../../UpdatedSnodgrass/${oneFile}</Picture>"
    echo "<duration>3000</duration>"
    echo "<expectedResponse>"
    echo "    <key>C</key>"
    echo "    <count>0</count>"
    echo "</expectedResponse>"

