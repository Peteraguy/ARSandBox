#!/bin/bash

dire=$1
step=$2
upLimit=$3 
dnLimit=$4
SBCommand="heightMapPlane"
NamedPipe="$HOME/src/Common/SandboxCmdPipe.fifo"

#colorMap
#waterSpeed
#waterMaxSteps
#waterAttenuation
#heightMapPlane
#dippingBed
#foldedDippingBed
#dippingBedThickness

echo $dire $step
curHeight=$( cat $HOME/src/Common/HeightColourMaps/Height_file.tmp )

echo "Current height is " $curHeight

if [ $dire = "UP" ]; then
	curHeight=$(($curHeight+$step))
    if (($curHeight > $upLimit)); then
        curHeight=$(($curHeight-$step))
    fi
else
   curHeight=$(($curHeight-$step))
    if (($curHeight < $dnLimit)); then
        curHeight=$(($curHeight+$step))
    fi
fi


FIFCMD=$SBCommand" 0 0 1 "$curHeight
echo $curHeight > $HOME/src/Common/HeightColourMaps/Height_file.tmp
echo "FIFCMD " $FIFCMD
echo $FIFCMD > $NamedPipe
