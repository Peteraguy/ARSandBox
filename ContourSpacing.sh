#!/bin/bash

MinSpace=$1
MaxSpace=$2
Step=$3
Direction=$4
SBCommand="contourLineSpacing"
StateFile="$HOME/src/Common/Contours/ContourSpacingStateFile.tmp" 
NamedPipe="$HOME/src/Common/SandboxCmdPipe.fifo"
curState=""

# pick up current statefile
if [ -f "$StateFile" ]; then
    # statefile exists get content
    curState=$( cat $StateFile )
else
    # no statefile just set default value     
    if [ $curState="" ]; then
	    curState="0,UP" 
    fi
fi

echo "Current state is " $curState

# get current spacing from statefile value
Spacing=${curState%","*}   # remove prefix ending in ","

# there is no direction value get it from the current state
if [ -z "$4" ]; then
    Direction=${curState#*","}
fi

# increment the spacing and flip direction if max or min 
if [ $Direction = "UP" ]; then
    NewSpacing="$(echo "${Spacing} + ${Step}" | bc)"
    if [ 1 -eq "$(echo "${NewSpacing} >= ${MaxSpace}" | bc)"  ]; then			
        if [  -z "$4" ]; then
            Direction="DN"
        else
            NewSpacing=$MaxSpace 
        fi
    fi
else
    NewSpacing="$(echo "${Spacing} - ${Step}" | bc)"
	if [ 1 -eq "$(echo "${NewSpacing} <= ${MinSpace}" | bc)" ]; then
        if [  -z "$4" ]; then		
            Direction="UP"
        else
            NewSpacing=$MinSpace
        fi
	fi
fi

# Build commands
StatusLn="$NewSpacing","$Direction" 
FIFOCMD=$SBCommand" "$NewSpacing

# debugging 
#echo "MinSpace " $MinSpace
#echo "MaxSpace " $MaxSpace
#echo "Step " $Step
#echo "Direction " $Direction
#echo "NewSpacing " $NewSpacing
#echo "Spacing " $Spacing
#echo "StatusLn " $StatusLn
echo "FIFOCMD " $FIFOCMD

# store state and pass to pipe
echo $StatusLn > $StateFile
echo $FIFOCMD > $NamedPipe


  
  
  


