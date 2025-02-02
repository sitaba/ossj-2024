#!/bin/bash -e

TARGET=${TARGET:="agl-kvm-demo"}
#TMP_TARGET=${TMP_TARGET:="rpi-u-boot-scr"}
AGL_BRANCH=${AGL_BRANCH:="quillback"}
MACHINE=${MACHINE:="raspberrypi4"}
MANIFEST=${MANIFEST:="quillback_17.1.1.xml"}
FEATURES=${FEATURES:="agl-demo agl-devel agl-kvm"}
LOCAL_CONF=$( 
cat <<- EOF
	DISTRO_FEATURES:append = " USB_BOOT"
EOF
)
BBLAYERS_CONF=${BBLAYERS_CONF:=""}
WS_DIR=${WS_DIR:="/workspace"}
USE_META_LOCAL="true"

source ${WS_DIR}/scripts/agl-builder.sh

main $@
