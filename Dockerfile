FROM daeks/steamcmd:latest
LABEL maintainer="github.com/daeks"

ENV STEAMAPPID 403240
ENV STEAMAPPDIR /home/steam/squad
ENV MODE COMPOSE

RUN set -x &&\
  mkdir -p $STEAMAPPDIR
  
USER root
RUN mkdir -p $STEAMAPPDIR/SquadGame/ServerConfig/ &&\
  chown -R $USERNAME:$USERNAME $STEAMAPPDIR/SquadGame/ServerConfig/
RUN mkdir -p $STEAMAPPDIR/SquadGame/Saved/Logs/ &&\
  chown -R $USERNAME:$USERNAME $STEAMAPPDIR/SquadGame/Saved/Logs/
RUN mkdir -p $STEAMAPPDIR/SquadGame/Saved/Crashes/ &&\
  chown -R $USERNAME:$USERNAME $STEAMAPPDIR/SquadGame/Saved/Crashes/
USER $USERNAME

RUN if [ "$MODE" = "INSTALL" ]; then set -x &&\
    "${STEAMCMDDIR}/steamcmd.sh" +login anonymous \
      +force_install_dir $STEAMAPPDIR +app_update $STEAMAPPID validate +quit; \
  fi

ENV CUSTOM= \
  PORT=7787 \
  QUERYPORT=27165 \
  RCONPORT=21114 \
  FIXEDMAXPLAYERS=80 \
  RANDOM=ALWAYS

WORKDIR $STEAMAPPDIR

VOLUME $STEAMAPPDIR

ENTRYPOINT $STEAMCMDDIR/steamcmd.sh \
    +login anonymous +force_install_dir $STEAMAPPDIR +app_update $STEAMAPPID +quit &&\
    $STEAMAPPDIR/SquadGameServer.sh \
      Port=$PORT QueryPort=$QUERYPORT RCONPORT=$RCONPORT FIXEDMAXPLAYERS=$FIXEDMAXPLAYERS RANDOM=$RANDOM $CUSTOM

EXPOSE $PORT/udp \
  $QUERYPORT/tcp \
  $QUERYPORT/udp \
  $RCONPORT/tcp \
  $RCONPORT/udp