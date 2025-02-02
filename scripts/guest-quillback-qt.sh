#!/bin/bash -e

TARGET=${TARGET:="agl-ivi-demo-qt"}
TMP_TARGET="qtxmlpatterns qtvirtualkeyboard"
AGL_BRANCH=${AGL_BRANCH:="quillback"}
MACHINE=${MACHINE:="virtio-aarch64"}
MANIFEST=${MANIFEST:="quillback_17.1.1.xml"}
FEATURES=${FEATURES:="agl-demo agl-devel"}
LOCAL_CONF=${LOCAL_CONF:=""}
BBLAYERS_CONF=${BBLAYERS_CONF:=""}
WS_DIR=${WS_DIR:="/workspace"}
USE_META_LOCAL="true"

source ${WS_DIR}/scripts/agl-builder.sh

main $@
