FROM daeks/steamcmd:latest
LABEL maintainer="github.com/daeks"

ENV STEAMAPPID 403240
ENV STEAMAPPDIR /home/steam/squad-dedicated
ENV MODE COMPOSE

RUN if [ "$BUILD" = "INSTALL" ]; then set -x &&\
  ${STEAMCMDDIR}/steamcmd.sh +login anonymous \
    +force_install_dir ${STEAMAPPDIR} +app_update ${STEAMAPPID} validate +quit &&\
  fi

ENV CUSTOM= \
  PORT=7787 \
  QUERYPORT=27165 \
  RCONPORT=21114 \
  FIXEDMAXPLAYERS=80 \
  RANDOM=ALWAYS

WORKDIR $STEAMAPPDIR
VOLUME $STEAMAPPDIR

ENTRYPOINT ${STEAMCMDDIR}/steamcmd.sh \
    +login anonymous +force_install_dir ${STEAMAPPDIR} +app_update ${STEAMAPPID} +quit &&\
    ${STEAMAPPDIR}/SquadGameServer.sh \
      Port=$PORT QueryPort=$QUERYPORT RCONPORT=$RCONPORT FIXEDMAXPLAYERS=$FIXEDMAXPLAYERS RANDOM=$RANDOM $CUSTOM

EXPOSE $PORT/udp \
  $QUERYPORT/tcp \
  $QUERYPORT/udp \
  $RCONPORT/tcp \
  $RCONPORT/udp