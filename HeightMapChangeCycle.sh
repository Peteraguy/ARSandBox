#!/bin/bash

# ColourMap_Hard_1.cpt 
MapFilePref=$1

if [ "$2" != "" ]; then
    MapFileExtn=$2
else
    MapFileExtn="cpt"
fi
MinMap=2
MaxMap=12
SBCommand="colorMap"
NamedPipe="$HOME/src/Common/SandboxCmdPipe.fifo"

# pick up current state
curMap=""
curMap=$( cat $HOME/src/Common/HeightColourMaps/switch_file.tmp )
if [ $curMap = "" ]; then
	curMap=$MapFilePref "_" $MinMap "." $MapFileExtn "?UP" 
fi
echo "Current state is " $curMap

tmp=${curMap#*_}   # remove prefix ending in "_"

mapNo=${tmp%"."*}

dire=${curMap#*"?"}

 
if [ $dire = "UP" ]; then
	nextNo=$(($mapNo+1))
	if [ $nextNo = $MaxMap ]; then	
		dire="DN"
	fi
else
   nextNo=$(($mapNo-1))
	if [ $nextNo = $MinMap ]; then	
		dire="UP"
	fi
fi

#echo "MapFilePref " $MapFilePref
#echo "nextNo " $nextNo
#echo "MapFileExtn " $MapFileExtn

NewFile="$MapFilePref"_"$nextNo"."$MapFileExtn"
StatusLn="$NewFile"?"$dire" 
FIFCMD=$SBCommand" "$HOME/src/Common/HeightColourMaps/$MapFilePref/$NewFile

#echo "NewFile " $NewFile
#echo "StatusLn " $StatusLn

echo $StatusLn > $HOME/src/Common/HeightColourMaps/switch_file.tmp
echo "FIFCMD " $FIFCMD
echo $FIFCMD > $NamedPipe

#ColourMap-Soft_1.cpt?UP
  
  
  


