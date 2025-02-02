#FILESEXTRAPATHS:prepend := "${@bb.utils.contains('DISTRO_FEATURES', 'USB_BOOT', '${THISDIR}/base-files:', '', d)}"
FILESEXTRAPATHS:prepend := "${THISDIR}/base-files:"
