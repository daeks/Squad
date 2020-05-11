#!/bin/bash
PID=$(pgrep -f "Linux/SquadGameServer")
if $PID > /dev/null
then
    echo "SquadGameServer running on PID #$PID - Port: $PORT / $QUERYPORT / $RCONPORT" && exit 0
else
    echo "SquadGameServer STOPPED" && exit 1
fi