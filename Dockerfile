FROM daeks/steamcmd:latest
LABEL maintainer="github.com/daeks"

ENV STEAMAPPID 403240
ENV STEAMAPPDIR $STEAMHOMEDIR/squad
ENV VERBOSE OFF

ENV STEAMWORKSHOPID 393380
ENV STEAMWORKSHOPCFG $STEAMAPPDIR/SquadGame/ServerConfig/Mods.cfg
ENV STEAMWORKSHOPDIR $STEAMAPPDIR/SquadGame/Plugins/Mods
ENV STEAMWORKSHOPTMP /tmp/$STEAMWORKSHOPID

ENV MODE COMPOSE

RUN [ "/bin/bash", "-c", "mkdir -p $STEAMAPPDIR/SquadGame/{ServerConfig,Saved/{Logs,Crashes}}" ]

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

COPY ./status.sh $STEAMHOMEDIR/status.sh
COPY ./squad.sh $STEAMHOMEDIR/squad.sh
COPY ./mods.sh $STEAMHOMEDIR/mods.sh
USER root
RUN chown $USERNAME:$USERNAME $STEAMHOMEDIR/status.sh && chmod +x $STEAMHOMEDIR/status.sh
RUN chown $USERNAME:$USERNAME $STEAMHOMEDIR/squad.sh && chmod +x $STEAMHOMEDIR/squad.sh
RUN chown $USERNAME:$USERNAME $STEAMHOMEDIR/mods.sh && chmod +x $STEAMHOMEDIR/mods.sh

RUN if [ "$MODE" = "INSTALL" ]; then set -x &&\
    $STEAMHOMEDIR/mods.sh; \
  fi

USER $USERNAME

HEALTHCHECK CMD $STEAMHOMEDIR/status.sh

WORKDIR $STEAMAPPDIR
VOLUME $STEAMAPPDIR

ENTRYPOINT $STEAMHOMEDIR/squad.sh

EXPOSE $PORT/udp \
  $QUERYPORT/tcp \
  $QUERYPORT/udp \
  $RCONPORT/tcp \
  $RCONPORT/udp