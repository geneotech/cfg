#!/usr/bin/env bash 
CONFIGURATION=$1
ARCHITECTURE=$2

if [[ -z "$ARCHITECTURE" ]]
then
	ARCHITECTURE="x64"
fi

./build.sh $1 $2

TARGET_DIR="build/${CONFIGURATION}-${ARCHITECTURE}"
cd $TARGET_DIR
make run
