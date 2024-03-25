NEOTERM_PKG_HOMEPAGE=https://mj.ucw.cz/sw/pciutils/
NEOTERM_PKG_DESCRIPTION="a collection of programs for inspecting and manipulating configuration of PCI devices"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.10.0
NEOTERM_PKG_SRCURL=https://mj.ucw.cz/download/linux/pci/pciutils-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=7deabe38ae5fa88a96a8c4947975cf31c591506db546e9665a10dddbf350ead0
NEOTERM_PKG_DEPENDS="libandroid-glob, zlib"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"

	# ${str^^} returns upper case string
	local _ARCH=${NEOTERM_ARCH^^}
	if [[ ${_ARCH} == "ARM" ]]; then
		_ARCH="ARMV7L"
	fi

	local f
	for f in config.h config.mk; do
		local in=$NEOTERM_PKG_BUILDER_DIR/$NEOTERM_PKG_VERSION/${f}.in
		local out=$NEOTERM_PKG_SRCDIR/lib/${f}
		sed \
			-e 's|@NEOTERM_ARCH@|'"${_ARCH}"'|g' \
			-e 's|@NEOTERM_PREFIX@|'"${NEOTERM_PREFIX}"'|g' \
			${in} > ${out}
	done
}
