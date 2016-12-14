#!/bin/bash
echo '<?xml version="1.0" encoding="UTF-8"?>'
echo "<!-- Must be a top level tag to include all tags to include -->"
echo "<IncludeSlides>"
echo 

# print intro slide
echo "    <Slide>"
echo "        <name>Directions</name>"
echo "        <duration>10000</duration>"
echo "        <text>You will see a series of images."
echo "Some new, some prevously viewed during training."
echo 'Press the "C" key when you see images previously viewed during training.</text>'
echo "        <color>Black</color>"
echo "        <font>Arial</font>"
echo "        <fontsize>24</fontsize>"
echo "        <backGroundColor>White</backGroundColor>"
echo "    </Slide>"
echo 

# print NoImg slide
echo "    <Slide>"
echo "        <name>NoImg</name>"
echo "        <condition>3</condition>"
echo "        <duration>500</duration>"
echo "        <backGroundColor>White</backGroundColor>"
echo "    </Slide>"
echo

# print Goodbye slide
echo "    <Slide>"
echo "        <name>Goodbye</name>"
echo "        <text>Goodbye.</text>"
echo "        <font>Arial</font>"
echo "        <fontsize>24</fontsize>"
echo "        <duration>1000</duration>"
echo "    </Slide>"
echo

for oneFile in *jpeg
do
    # let's skip position right now
    fname=`basename ${oneFile}`
    output=${fname/.jpeg/}

    case "$output" in
        016|081|118|163|211)
            condition=2
            ;;
        *)
            condition=1
            ;;
    esac
    
    echo "    <Slide>"
    echo "        <name>IMG${output}</name>"
    echo "        <condition>${condition}</condition>"
    # make sure path below is correct
    echo "        <Picture>./UpdatedSnodgrass/${fname}</Picture>"
    echo "        <duration>2500</duration>"
    echo "        <expectedResponse>"
    echo "            <key>C</key>"
    echo "            <count>1</count>"
    echo "        </expectedResponse>"
    echo "    </Slide>"
    echo 
done

echo "</IncludeSlides>"
