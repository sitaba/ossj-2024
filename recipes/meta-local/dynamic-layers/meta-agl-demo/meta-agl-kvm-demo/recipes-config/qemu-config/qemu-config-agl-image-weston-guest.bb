SUMMARY     = "Setting files for agl-image-weston-flutter guest VM"
LICENSE     = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit systemd allarch

#
#SRC_URI = "file://${QEMU_IMAGE}.conf"
#
SRC_URI = "file://agl-ivi-demo-guest.conf"

do_configure[noexec] = "1"
do_compile[noexec] = "1"

#
#QEMU_IMAGE = "agl-image-weston-guest"
#
QEMU_IMAGE = "${QEMU_IMAGE_WESTON}"
QEMU_UNIT = "agl-qemu-runner@${QEMU_IMAGE}.service"

QEMU_IMAGE_WESTON= "agl-image-weston-guest"
QEMU_IMAGE_KIRKSTONE = "agl-ivi-demo-kirkstone"
QEMU_IMAGE_SCARTHGAP = "agl-ivi-demo-scarthgap"

SYSTEMD_AUTO_ENABLE:${PN} = "false"

do_install() {
    # Install template unit links
    install -d ${D}${systemd_system_unitdir}
    ln -sf agl-qemu-runner@.service ${D}${systemd_system_unitdir}/${QEMU_UNIT}
    #ln -sf agl-qemu-runner@.service ${D}${systemd_system_unitdir}/${QEMU_IMAGE_KIRKSTONE}.service
    #ln -sf agl-qemu-runner@.service ${D}${systemd_system_unitdir}/${QEMU_IMAGE_SCARTHGAP}.service
    install -d ${D}${systemd_system_unitdir}/multi-user.target.wants
    ln -sf ${systemd_system_unitdir}/${QEMU_UNIT} ${D}${systemd_system_unitdir}/multi-user.target.wants/${QEMU_UNIT}

    # Install conf file
    install -d ${D}${sysconfdir}/agl-qemu-runner
    install -m 0644 ${WORKDIR}/agl-ivi-demo-guest.conf ${D}${sysconfdir}/agl-qemu-runner/${QEMU_IMAGE_WESTON}.conf
    install -m 0644 ${WORKDIR}/agl-ivi-demo-guest.conf ${D}${sysconfdir}/agl-qemu-runner/${QEMU_IMAGE_KIRKSTONE}.conf
    install -m 0644 ${WORKDIR}/agl-ivi-demo-guest.conf ${D}${sysconfdir}/agl-qemu-runner/${QEMU_IMAGE_SCARTHGAP}.conf
}

FILES:${PN} += "${systemd_system_unitdir} ${sysconfdir}"

RDEPENDS:${PN} += "agl-qemu-runner qemu-config-vmnet0"
