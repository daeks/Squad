#!/bin/bash
$STEAMCMDDIR/steamcmd.sh +login anonymous +force_install_dir $STEAMAPPDIR +app_update $STEAMAPPID +quit

source $STEAMHOMEDIR/mods.sh

if [ "$VERBOSE" != "OFF" ]; then
  if [ -f $STEAMAPPDIR/SquadGame/Saved/Config/LinuxServer/Engine.ini ]; then
    if [ ! -f $STEAMHOMEDIR/.verbose ]; then
      echo $'[Core.Log]\nLogSquadScorePoints=verbose' >> $STEAMAPPDIR/SquadGame/Saved/Config/LinuxServer/Engine.ini
      echo '1' > $STEAMHOMEDIR/.verbose
    fi
  fi
fi

sed -i -e 's/Port=21114/'"Port=${RCONPORT}"'/g' "${STEAMAPPDIR}/SquadGame/ServerConfig/Rcon.cfg"
$STEAMAPPDIR/SquadGameServer.sh Port=$PORT QueryPort=$QUERYPORT RCONPORT=$RCONPORT FIXEDMAXPLAYERS=$FIXEDMAXPLAYERS RANDOM=$RANDOM $CUSTOM
