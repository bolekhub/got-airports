#!/bin/bash

di=$(pwd)
ARGUMENT="$1"
file_path=$(pwd)/Info.plist

if [ -z != $ARGUMENT ] 
then
file_path=$(pwd)/$ARGUMENT
fi

echo “Updating plist”
/usr/libexec/PlistBuddy -c "add :NSAppTransportSecurity:NSAllowsArbitraryLoads bool YES" $file_path