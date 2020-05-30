#!/bin/bash

if [ ! -d "$STEAMWORKSHOPTMP"]; then
  mkdir -p $STEAMWORKSHOPTMP
fi

if [ -f "$STEAMWORKSHOPCFG" ]; then
  if [ "$MODE" = "INSTALL" ]; then
    while read -r MODID do
      "${STEAMCMDDIR}/steamcmd.sh" +login anonymous +force_install_dir $STEAMWORKSHOPTMP +workshop_download_item $STEAMWORKSHOPID $MODID +quit
    done < "$STEAMWORKSHOPCFG"
  fi
else 
  echo "" > $STEAMWORKSHOPCFG
fi

rsync -rtvph --exclude='*[!0-9]*' $STEAMWORKSHOPTMP $STEAMWORKSHOPDIR -delete
rm -rf $STEAMWORKSHOPTMP/*