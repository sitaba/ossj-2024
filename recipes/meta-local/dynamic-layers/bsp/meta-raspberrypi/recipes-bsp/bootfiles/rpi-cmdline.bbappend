CMDLINE_ROOTFS := "${@bb.utils.contains('DISTRO_FEATURES', 'USB_BOOT', 'root=/dev/sda2 ${CMDLINE_ROOT_FSTYPE} rootwait', '${CMDLINE_ROOTFS}', d)}"
