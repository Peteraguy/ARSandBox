#!/bin/bash

ARR[1]="SurfaceAddWaterColor-Water.fs"
ARR[2]="SurfaceAddWaterColor-Snow.fs"
ARR[3]="SurfaceAddWaterColor-Ice.fs"
ARR[4]="SurfaceAddWaterColor-SparklyIce.fs"
ARR[5]="SurfaceAddWaterColor-PollutedWater.fs"
ARR[6]="SurfaceAddWaterColor-Lava.fs"
ARR[7]="SurfaceAddWaterColor-ToxicWaste.fs"
ARR[8]="SurfaceAddWaterColor-ToxicDeath.fs"

# pick up current state
curID=$( cat ./switch_file.tmp )

echo "Current shader is $curID ${ARR[$curID]} of ${#ARR[@]}" 

if [ $curID = ${#ARR[@]} ]; then
	curID=1
else
   curID=$(($curID+1))
fi

echo "New shader is $curID ${ARR[$curID]} of ${#ARR[@]}" 

sh $HOME/src/Common/Shaders/wkSwitchShader.sh "${ARR[$curID]}"

echo $curID > ./switch_file.tmp

