FROM daeks/steamcmd:latest
LABEL maintainer="github.com/daeks"

ARG USERNAME=steam

ENV STEAMAPPID 403240
ENV STEAMAPPDIR /home/steam/squad
ENV MODE COMPOSE

RUN set -x &&\
  su - ${USERNAME} -c "mkdir -p ${STEAMAPPDIR} && cd ${STEAMAPPDIR}"

RUN if [ "$MODE" = "INSTALL" ]; then set -x &&\
    su - ${USERNAME} -c "${STEAMCMDDIR}/steamcmd.sh"+login anonymous \
      +force_install_dir ${STEAMAPPDIR} +app_update ${STEAMAPPID} validate +quit;" \
  fi

ENV CUSTOM= \
  PORT=7787 \
  QUERYPORT=27165 \
  RCONPORT=21114 \
  FIXEDMAXPLAYERS=80 \
  RANDOM=ALWAYS

USER $USERNAME
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