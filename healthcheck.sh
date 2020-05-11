#!/bin/bash
if pgrep -lf "Linux/SquadGameServer" > /dev/null
then
    echo "SquadGameServer Running" && exit 0
else
    echo "SquadGameServer Stopped" && exit 1
fi