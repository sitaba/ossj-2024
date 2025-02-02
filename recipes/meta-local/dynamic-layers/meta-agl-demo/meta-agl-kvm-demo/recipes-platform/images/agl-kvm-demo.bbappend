GUEST_VM1_IMAGE = "agl-image-weston-guest"
GUEST_VM2_IMAGE = "agl-cluster-demo-qt-guest"

IMAGE_INSTALL:append = " \
    picocom \
"
#
#    usb-boot \
#

IMAGE_ROOTFS_EXTRA_SPACE = "4194304"

require usb-boot.inc
