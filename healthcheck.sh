#!/bin/bash
if [ $(pgrep -f 'Linux/SquadGameServer') > /dev/null ];
then
    echo "SquadGameServer running on PID #$(pgrep -f 'Linux/SquadGameServer') - Port: $PORT / $QUERYPORT / $RCONPORT" && exit 0;
else
    echo "SquadGameServer STOPPED" && exit 1;
fi