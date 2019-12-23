#!/bin/bash

SBCommand="useContourLines"
StateFile="$HOME/src/Common/Contours/ContourStateFile.tmp" 
NamedPipe="$HOME/src/Common/SandboxCmdPipe.fifo"

if [ -z "$1" ]; then
    # state no passed
    # pick up current statefile
    if [ -f "$StateFile" ]; then
        # statefile exists get content
        curState=$( cat $StateFile )
        if [ $curState = "1" ]; then
            curState="0"
        else
            curState="1"
        fi
    else
        # no statefile just set default value     
        if [ $curState="" ]; then
	        curState="1" 
        fi
    fi
else
    curState=$1
fi

# Build commands
StatusLn="$curState" 
FIFOCMD=$SBCommand" "$curState

# debugging 
#echo "curState " $curState
#echo "StatusLn " $StatusLn
echo "FIFOCMD " $FIFOCMD

# store state and pass to pipe
echo $StatusLn > $StateFile
echo $FIFOCMD > $NamedPipe


  
  
  


