#!/bin/bash
if [ $(pgrep -f 'Linux/SquadGameServer') > /dev/null ]; then
    if [ "$VERBOSE" != "OFF" ]; then
      if [ -f $STEAMAPPDIR/SquadGame/Saved/Config/LinuxServer/Engine.ini ]; then
        if [ ! -f $STEAMHOMEDIR/.verbose ]; then
          echo $'[Core.Log]\nLogSquadScorePoints=verbose' >> $STEAMAPPDIR/SquadGame/Saved/Config/LinuxServer/Engine.ini
          echo '1' > $STEAMHOMEDIR/.verbose
        fi
      fi
    fi
    
    echo "SquadGameServer running on PID #$(pgrep -f 'Linux/SquadGameServer') - Port: $PORT / $QUERYPORT / $RCONPORT" && exit 0
else
    exit 1
fi