FROM daeks/steamcmd:latest

LABEL maintainer="daeks"

ENV STEAMAPPID 403240
ENV STEAMAPPDIR /home/steam/squad-dedicated

RUN set -x \
	&& "${STEAMCMDDIR}/steamcmd.sh" \
		+login anonymous \
		+force_install_dir ${STEAMAPPDIR} \
		+app_update ${STEAMAPPID} validate \
		+quit

ENV CUSTOM= \
    PORT=7787 \
	QUERYPORT=27165 \
	RCONPORT=21114 \
	FIXEDMAXPLAYERS=80 \
	RANDOM=ALWAYS

WORKDIR $STEAMAPPDIR
VOLUME $STEAMAPPDIR

ENTRYPOINT ${STEAMCMDDIR}/steamcmd.sh \
		+login anonymous +force_install_dir ${STEAMAPPDIR} +app_update ${STEAMAPPID} +quit \
		&& ${STEAMAPPDIR}/SquadGameServer.sh \
			Port=$PORT QueryPort=$QUERYPORT RCONPORT=$RCONPORT FIXEDMAXPLAYERS=$FIXEDMAXPLAYERS RANDOM=$RANDOM $CUSTOM

EXPOSE 7787/udp \
	27165/tcp \
	27165/udp \
	21114/tcp \
	21114/udp