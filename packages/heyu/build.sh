NEOTERM_PKG_HOMEPAGE=https://www.heyu.org/
NEOTERM_PKG_DESCRIPTION="Program for remotely controlling lights and appliances"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1:2.10.3
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL="https://github.com/HeyuX10Automation/heyu/archive/v${NEOTERM_PKG_VERSION:2}.tar.gz"
NEOTERM_PKG_SHA256=0c3435ea9cd57cd78c29047b9c961f4bfbec39f42055c9949acd10dd9853b628
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	# rindex is an obsolete version of strrchr which is not available in Android:
	CFLAGS+=" -Drindex=strrchr"
	sed -e "s|@NEOTERM_CC@|${CC}|g" \
		-e "s|@NEOTERM_PREFIX@|${NEOTERM_PREFIX}|g" \
		"${NEOTERM_PKG_BUILDER_DIR}"/Configure.diff | patch -p1
}

neoterm_step_configure() {
	./Configure linux
}
