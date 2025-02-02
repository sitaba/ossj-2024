#!/bin/bash -e

TARGET=${TARGET:="agl-ivi-demo-flutter"}
TMP_TARGET=""
AGL_BRANCH=${AGL_BRANCH:="master"}
MACHINE=${MACHINE:="virtio-aarch64"}
MANIFEST=${MANIFEST:="ricefish_17.92.0.xml"}
FEATURES=${FEATURES:="agl-demo"}
LOCAL_CONF=${LOCAL_CONF:=""}
BBLAYERS_CONF=${BBLAYERS_CONF:=""}
WS_DIR=${WS_DIR:="/workspace"}
USE_META_LOCAL="true"

source ${WS_DIR}/scripts/agl-builder.sh

main $@
