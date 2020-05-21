#!/bin/bash
$STEAMCMDDIR/steamcmd.sh +login anonymous +force_install_dir $STEAMAPPDIR +app_update $STEAMAPPID +quit 

if [ -f $STEAMAPPDIR/SquadGame/Saved/Config/LinuxServer/Engine.ini ]; then
  if [ -f $STEAMHOMEDIR/.engine_modified ]; then
    echo $'[Core.Log]\nLogSquadScorePoints=verbose' >> $STEAMAPPDIR/SquadGame/Saved/Config/LinuxServer/Engine.ini
    echo '1' > $STEAMHOMEDIR/.engine_modified
  fi
fi

$STEAMAPPDIR/SquadGameServer.sh Port=$PORT QueryPort=$QUERYPORT RCONPORT=$RCONPORT FIXEDMAXPLAYERS=$FIXEDMAXPLAYERS RANDOM=$RANDOM $CUSTOM