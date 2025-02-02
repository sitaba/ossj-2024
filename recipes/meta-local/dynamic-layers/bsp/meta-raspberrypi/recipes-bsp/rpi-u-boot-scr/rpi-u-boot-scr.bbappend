FILESEXTRAPATHS:prepend := "${@bb.utils.contains('DISTRO_FEATURES', 'USB_BOOT', '${THISDIR}/files:', '', d)}"

#
#FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
#FILESEXTRAPATHS:prepend := "${@bb.utils.contains('DISTRO_FEATURES', 'USB_BOOT', 'PPPPPPPP${THISDIR}/files:', '', d)}"
#
