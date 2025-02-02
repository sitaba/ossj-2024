#!/bin/bash -e

TARGET=${TARGET:="agl-kvm-demo"}
TMP_TARGET=${TMP_TARGET:=""}
AGL_BRANCH=${AGL_BRANCH:="quillback"}
MACHINE=${MACHINE:="raspberrypi4"}
MANIFEST=${MANIFEST:="quillback_17.1.1.xml"}
FEATURES=${FEATURES:="agl-demo agl-devel agl-kvm"}
LOCAL_CONF=${LOCAL_CONF:=""}
BBLAYERS_CONF=${BBLAYERS_CONF:=""}
WS_DIR=${WS_DIR:="/workspace"}

USE_META_LOCAL=${USE_META_LOCAL:="true"}

RECIPES_BASE=${WS_DIR}/recipes
RECIPES_DIR=${RECIPES_BASE}/${AGL_BRANCH}_${MANIFEST}
BUILD_DIR_BASE=${WS_DIR}/build
BUILD_DIR=${BUILD_DIR_BASE}/${AGL_BRANCH}

info () { echo [info] "$@"; }
warn () { echo [warn] "$@"; }
erro () { echo [erro] "$@"; }

show_help()
{
	cat <<- EOF
		Usage: $0 <option>

		Options:
		    -d, --downloads: download source code
		    -s, --source   : setup and load environemnt variables
		    -b, --build    : build image
	EOF
}

download_src()
{
	info "START: ${FUNCNAME[0]}"
	cd $WS_DIR
	if [ ! -d "${RECIPES_DIR}" ];
	then
		if [ -d "${RECIPES_BASE}/tmp-recipes" ]; then rm -rf ${RECIPES_BASE}/tmp-recipes; fi
		mkdir -p ${RECIPES_BASE}/tmp-recipes
		cd ${RECIPES_BASE}/tmp-recipes

		repo init -b $AGL_BRANCH -m $MANIFEST --manifest-depth=1 --depth=1 \
			-u https://gerrit.automotivelinux.org/gerrit/AGL/AGL-repo
		cp .repo/manifests/$MANIFEST .repo/manifests/${MANIFEST}.back
		sed -i 's@name="openembedded@clone-depth="1" name="openembedded@' .repo/manifests/$MANIFEST
		sed -i 's@name="renesas-rcar@clone-depth="1" name="renesas-rcar@' .repo/manifests/$MANIFEST
		repo sync --current --no-tags -j$(nproc)

		cd ${RECIPES_BASE}
		mv tmp-recipes ${RECIPES_DIR}
	fi
	info "DONE: ${FUNCNAME[0]}"	
}

source_env()
{
	info "START: ${FUNCNAME[0]}"
	cd $RECIPES_DIR
	source meta-agl/scripts/aglsetup.sh -f -m $MACHINE -b $BUILD_DIR $FEATURES

	if [ "$USE_META_LOCAL" == "true" ]; then
		info "META_LOCAL: USE"
		bitbake-layers add-layer $RECIPES_BASE/meta-local
	else
		info "META_LOCAL: NO USE"
	fi

	cat >>"conf/local.conf" <<- EOF
		$LOCAL_CONF
	EOF

	cat >>"conf/bblayers.conf" <<- EOF

		$BBLAYERS_CONF
	EOF
		#SSTATE_MIRRORS:append = " file://.* https://download.automotivelinux.org/sstate-mirror/${AGL_BRANCH}/\${DEFAULTTUNE}/PATH \\n "
	info "DONE: ${FUNCNAME[0]}"	
}

build_img()
{
	if [ -n "$TMP_TARGET" ]; then
		info "START: TMP_TARGET BUILD"
		info " --- TMP_TARGET: $TMP_TARGET"
		bitbake -c cleanall $TMP_TARGET
		info "DONE: TMP_TARGET CLEAN"	
		bitbake $TMP_TARGET
		info "DONE: TMP_TARGET BUILD"	
		return
	fi

	info "START: ${FUNCNAME[0]}"
	time bitbake --continue $TARGET
	info "DONE: ${FUNCNAME[0]}"	
}

show_settings()
{
	info "START: ${FUNCNAME[0]}"
	cat <<- EOF
		============================
		  MACHINE : $MACHINE
		  TARGET  : $TARGET
		  FEATURES: $FEATURES
		============================
	EOF
	info "DONE: ${FUNCNAME[0]}"	
}

main()
{
	if [ $# -eq 0 ]; then show_help; fi

	case $1 in
		-h | --help )
			show_help
			exit 1
			;;
		-d | --download )
			download_src
			;;
		-s | --source )
			download_src
			show_settings
			source_env
			;;
		-b | --build )
			download_src
			source_env
			show_settings
			build_img
			;;
		*)
			erro "Unkown option: $1"
			show_help
			exit 1
			;;
	esac
}
