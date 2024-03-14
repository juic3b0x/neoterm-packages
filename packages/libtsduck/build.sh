NEOTERM_PKG_HOMEPAGE=https://tsduck.io/
NEOTERM_PKG_DESCRIPTION="An extensible toolkit for MPEG transport streams"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.36.3528"
_VERSION=$(echo "${NEOTERM_PKG_VERSION}" | sed 's/\./-/2')
NEOTERM_PKG_SRCURL=https://github.com/tsduck/tsduck/archive/refs/tags/v${_VERSION}.tar.gz
NEOTERM_PKG_SHA256=068ef1cbc60821a4cce8d50c876edef5150ad581b31f4a92f085e20b3becd0eb
NEOTERM_PKG_DEPENDS="libandroid-glob, libc++, libcurl, libedit"
NEOTERM_PKG_HOSTBUILD=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_SED_REGEXP='s/-/./g'
NEOTERM_PKG_EXTRA_MAKE_ARGS="
ALTDEVROOT=${NEOTERM_PREFIX}
CROSS=1
CROSS_TARGET=${NEOTERM_ARCH}
NOCURL=
NODEKTEC=1
NOEDITLINE=
NOGITHUB=1
NOHIDES=
NOPCSC=1
NORIST=1
NOSRT=1
NOTELETEXT=1
NOTEST=1
NOVATEK=1
SYSPREFIX=${NEOTERM_PREFIX}
USELIB64=
"
NEOTERM_PKG_RM_AFTER_INSTALL="
etc/security
etc/udev
"

neoterm_step_post_get_source() {
	# Needs to call `neoterm_step_configure_autotools` for `*-config` hack.
	touch configure
	chmod u+x configure
}

neoterm_step_host_build() {
	find $NEOTERM_PKG_SRCDIR -mindepth 1 -maxdepth 1 -exec cp -a \{\} ./ \;
	make -j $NEOTERM_MAKE_PROCESSES \
		NOCURL=1 \
		NODEKTEC=1 \
		NOEDITLINE=1 \
		NOGITHUB=1 \
		NOHIDES=1 \
		NOPCSC=1 \
		NORIST=1 \
		NOSRT=1 \
		NOTELETEXT=1 \
		NOTEST=1 \
		NOVATEK=1
}

neoterm_step_pre_configure() {
	PATH=$NEOTERM_PKG_HOSTBUILD_DIR/bin/release:$PATH

	CXXFLAGS+=" -fno-strict-aliasing"
	LDFLAGS+=" -landroid-glob"
}

neoterm_step_make() {
	sed \
		-e "s|\$(call F_SEARCH_CROSS,g++)|${CXX}|g" \
		-e "s|\$(call F_SEARCH_CROSS,gcc)|${CC}|g" \
		-e "s|\$(call F_SEARCH_CROSS,ld)|${LD}|g" \
		-i ${NEOTERM_PKG_SRCDIR}/Makefile.inc
	make -j $NEOTERM_MAKE_PROCESSES \
		CXX="$CXX" \
		GCC="$CC" \
		LD="$LD" \
		CXXFLAGS_CROSS="$CXXFLAGS $CPPFLAGS" \
		LDFLAGS_CROSS="$LDFLAGS" \
		${NEOTERM_PKG_EXTRA_MAKE_ARGS}
}
