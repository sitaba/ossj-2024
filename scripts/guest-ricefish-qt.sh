#!/bin/bash -e

TARGET=${TARGET:="agl-ivi-demo-qt"}
#TARGET="agl-ivi-demo-qt"
#TMP_TARGET=${TMP_TARGET:="clang mozjs-115 flutter-engine librsvg libqtappfw agl-service-audiomixer agl-service-hvac llvm"}
TMP_TARGET=""
AGL_BRANCH=${AGL_BRANCH:="ricefish"}
MACHINE=${MACHINE:="virtio-aarch64"}
MANIFEST=${MANIFEST:="ricefish_18.0.1.xml"}
FEATURES=${FEATURES:="agl-demo"}
LOCAL_CONF=$(cat <<- EOF
	#BB_NUMBER_THREADS = "$(( $(nproc) / 4 ))"
	#PARALLEL_MAKE = "-j $(( $(nproc) / 4 ))"
	#BB_NUMBER_THREADS = "1"
	#PARALLEL_MAKE = "1"
EOF
)
LOCAL_CONF=""
BBLAYERS_CONF=${BBLAYERS_CONF:=""}
WS_DIR=${WS_DIR:="/workspace"}
USE_META_LOCAL="false"

source ${WS_DIR}/scripts/agl-builder.sh

main $@
