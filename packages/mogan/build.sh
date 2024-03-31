NEOTERM_PKG_HOMEPAGE=https://github.com/XmacsLabs/mogan
NEOTERM_PKG_DESCRIPTION="A structure editor forked from GNU TeXmacs"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.1.6
NEOTERM_PKG_SRCURL=https://github.com/XmacsLabs/mogan/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=23ae08cd3c2af99d952b5ec37253ee639519402784b8766f37b2d223587659ab
NEOTERM_PKG_DEPENDS="freetype, ghostscript, libandroid-complex-math, libandroid-execinfo, libandroid-spawn, libc++, libcurl, libiconv, libjpeg-turbo, libpng, libsqlite, mogan-data, qt5-qtbase, qt5-qtsvg, which, zlib"
NEOTERM_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools"
NEOTERM_PKG_ANTI_BUILD_DEPENDS="which"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	neoterm_setup_cmake
	neoterm_setup_xmake

	# xmake tests -ldl wrongly?
	LD="${CXX}"

	if [[ "${NEOTERM_ON_DEVICE_BUILD}" == "false" ]]; then
		install -Dm755 "${NEOTERM_PKG_BUILDER_DIR}/qmake.sh" "${NEOTERM_PKG_BUILDDIR}/bin/qmake"
		sed -e "s|@NEOTERM_PREFIX@|${NEOTERM_PREFIX}|g" -i "${NEOTERM_PKG_BUILDDIR}/bin/qmake"
		export PATH="${NEOTERM_PKG_BUILDDIR}/bin:${NEOTERM_PREFIX}/opt/qt/cross/bin:${PATH}"
		export QMAKESPEC="${NEOTERM_PREFIX}/lib/qt/mkspecs/neoterm-cross"
	fi

	command -v qmake
	qmake -query
}

neoterm_step_make() {
	local host_platform="${NEOTERM_ARCH}-linux-android"
	case "${NEOTERM_ARCH}" in
	arm) host_platform="armv7a-linux-androideabi" ;;
	esac

	echo "xrepo update-repo"
	xrepo update-repo

	echo "xmake config"
	xmake config \
		--yes \
		--verbose \
		--diagnosis \
		-m release \
		--sdk="${NEOTERM_STANDALONE_TOOLCHAIN}" \
		--cross="${host_platform}-" \
		--cflags="${CFLAGS}" \
		--cxxflags="${CXXFLAGS}" \
		--ldflags="${LDFLAGS}"

	echo "xmake build"
	xmake build \
		--yes \
		--verbose \
		--diagnosis \
		--jobs="${NEOTERM_MAKE_PROCESSES}" \
		--all
}

neoterm_step_make_install() {
	echo "xmake install"
	xmake install \
		--yes \
		--verbose \
		--diagnosis \
		-o "${NEOTERM_PREFIX}" \
		mogan_install

	mkdir -p $NEOTERM_PREFIX/share/Xmacs/plugins/shell/bin
	ln -sfTr $NEOTERM_PREFIX/{libexec,share}/Xmacs/plugins/shell/bin/tm_shell
}
