#!/bin/bash

FileName=$1

echo "Switch shader to " $FileName

cp $HOME/src/Common/Shaders/bin/$FileName /home/sandbox/src/SARndbox-2.6/share/SARndbox-2.6/Shaders/SurfaceAddWaterColor.fs
