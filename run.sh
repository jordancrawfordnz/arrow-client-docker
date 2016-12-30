#!/bin/bash

set -e

ARROW_CLIENT_OPTIONS=""

function process_options {
  if [ -n "${2}" ]; then
    camera_urls=(${2//,/ })
    for i in "${!camera_urls[@]}"
    do
      ARROW_CLIENT_OPTIONS+="-${1} ${camera_urls[i]} "
    done
  fi
}

process_options "r" ${RTSP_CAMERAS}
process_options "m" ${MJPEG_CAMERAS}
process_options "h" ${HTTP_CAMERAS}
process_options "t" ${TCP_CAMERAS}

ARROW_CLIENT_COMMAND="arrow-client arr-rs.angelcam.com:8900 -c /usr/share/ca-certificates -c /etc/arrow/ca.pem --config-file=/arrow-config/config.json ${ARROW_CLIENT_OPTIONS}"

eval $ARROW_CLIENT_COMMAND
