NEOTERM_PKG_HOMEPAGE=https://sw.kovidgoyal.net/kitty/
NEOTERM_PKG_DESCRIPTION="Cross-platform, fast, feature-rich, GPU based terminal"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
# When updating the package, also update terminfo for kitty by updating
# ncurses' kitty sources in main repo
NEOTERM_PKG_VERSION="0.31.0"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/kovidgoyal/kitty/releases/download/v${NEOTERM_PKG_VERSION}/kitty-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=d122497134abab8e25dfcb6b127af40cfe641980e007f696732f70ed298198f5
# fontconfig is dlopen(3)ed:
NEOTERM_PKG_DEPENDS="dbus, fontconfig, harfbuzz, libpng, librsync, libx11, libxkbcommon, littlecms, ncurses, opengl, openssl, python, xxhash, zlib"
NEOTERM_PKG_BUILD_DEPENDS="libxcursor, libxi, libxinerama, libxrandr, xorgproto"
NEOTERM_PKG_PYTHON_COMMON_DEPS="wheel"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_HOSTBUILD=true
NEOTERM_PKG_RM_AFTER_INSTALL="
share/doc/kitty/html
share/terminfo/x/xterm-kitty
"

neoterm_step_host_build() {
	if [[ "${NEOTERM_ON_DEVICE_BUILD}" == "true" ]]; then return; fi

	# https://github.com/kovidgoyal/kitty/issues/6354

	neoterm_setup_golang
	neoterm_setup_ninja

	# XXX: neoterm_setup_meson is not expected to be called in host build
	AR=;CC=;CFLAGS=;CPPFLAGS=;CXX=;CXXFLAGS=;LD=;LDFLAGS=;PKG_CONFIG=;STRIP=
	neoterm_setup_meson
	unset AR CC CFLAGS CPPFLAGS CXX CXXFLAGS LD LDFLAGS PKG_CONFIG STRIP

	local xcb_proto_ver=$(. ${NEOTERM_SCRIPTDIR}/packages/xcb-proto/build.sh; echo ${NEOTERM_PKG_VERSION})
	local xcb_proto_srcurl=$(. ${NEOTERM_SCRIPTDIR}/packages/xcb-proto/build.sh; echo ${NEOTERM_PKG_SRCURL})
	local xcb_proto_sha256=$(. ${NEOTERM_SCRIPTDIR}/packages/xcb-proto/build.sh; echo ${NEOTERM_PKG_SHA256})
	local libxcb_ver=$(. ${NEOTERM_SCRIPTDIR}/packages/libxcb/build.sh; echo ${NEOTERM_PKG_VERSION})
	local libxcb_srcurl=$(. ${NEOTERM_SCRIPTDIR}/packages/libxcb/build.sh; echo ${NEOTERM_PKG_SRCURL})
	local libxcb_sha256=$(. ${NEOTERM_SCRIPTDIR}/packages/libxcb/build.sh; echo ${NEOTERM_PKG_SHA256})
	local libxkbcommon_ver=$(. ${NEOTERM_SCRIPTDIR}/x11-packages/libxkbcommon/build.sh; echo ${NEOTERM_PKG_VERSION})
	local libxkbcommon_srcurl=$(. ${NEOTERM_SCRIPTDIR}/x11-packages/libxkbcommon/build.sh; echo ${NEOTERM_PKG_SRCURL})
	local libxkbcommon_sha256=$(. ${NEOTERM_SCRIPTDIR}/x11-packages/libxkbcommon/build.sh; echo ${NEOTERM_PKG_SHA256})
	local libx11_ver=$(. ${NEOTERM_SCRIPTDIR}/packages/libx11/build.sh; echo ${NEOTERM_PKG_VERSION})
	local libx11_srcurl=$(. ${NEOTERM_SCRIPTDIR}/packages/libx11/build.sh; echo ${NEOTERM_PKG_SRCURL})
	local libx11_sha256=$(. ${NEOTERM_SCRIPTDIR}/packages/libx11/build.sh; echo ${NEOTERM_PKG_SHA256})

	neoterm_download "${xcb_proto_srcurl}" "${NEOTERM_PKG_CACHEDIR}/$(basename ${xcb_proto_srcurl})" "${xcb_proto_sha256}"
	neoterm_download "${libxcb_srcurl}" "${NEOTERM_PKG_CACHEDIR}/$(basename ${libxcb_srcurl})" "${libxcb_sha256}"
	neoterm_download "${libxkbcommon_srcurl}" "${NEOTERM_PKG_CACHEDIR}/$(basename ${libxkbcommon_srcurl})" "${libxkbcommon_sha256}"
	neoterm_download "${libx11_srcurl}" "${NEOTERM_PKG_CACHEDIR}/$(basename ${libx11_srcurl})" "${libx11_sha256}"

	tar -xf "${NEOTERM_PKG_CACHEDIR}/$(basename "${xcb_proto_srcurl}")"
	tar -xf "${NEOTERM_PKG_CACHEDIR}/$(basename "${libxcb_srcurl}")"
	tar -xf "${NEOTERM_PKG_CACHEDIR}/$(basename "${libxkbcommon_srcurl}")"
	tar -xf "${NEOTERM_PKG_CACHEDIR}/$(basename "${libx11_srcurl}")"

	export PKG_CONFIG_PATH="${NEOTERM_PKG_HOSTBUILD_DIR}/lib/pkgconfig"
	PKG_CONFIG_PATH+=":${NEOTERM_PKG_HOSTBUILD_DIR}/share/pkgconfig"
	PKG_CONFIG_PATH+=":${NEOTERM_PKG_HOSTBUILD_DIR}/lib/x86_64-linux-gnu/pkgconfig"

	pushd "xcb-proto-${xcb_proto_ver}"
	./configure --prefix "${NEOTERM_PKG_HOSTBUILD_DIR}"
	make -j "${NEOTERM_MAKE_PROCESSES}" install
	popd
	pushd "libxcb-${libxcb_ver}"
	./configure --prefix "${NEOTERM_PKG_HOSTBUILD_DIR}"
	make -j "${NEOTERM_MAKE_PROCESSES}" install
	popd
	pushd "libxkbcommon-xkbcommon-${libxkbcommon_ver}"
	${NEOTERM_MESON} \
		${NEOTERM_PKG_HOSTBUILD_DIR}/build-xkbcommon . \
		--prefix "${NEOTERM_PKG_HOSTBUILD_DIR}" \
		-Denable-bash-completion=false \
		-Denable-wayland=false \
		-Denable-docs=false
	ninja \
		-C ${NEOTERM_PKG_HOSTBUILD_DIR}/build-xkbcommon \
		-j "${NEOTERM_MAKE_PROCESSES}" install
	popd
	pushd "libX11-${libx11_ver}"
	./configure --prefix "${NEOTERM_PKG_HOSTBUILD_DIR}"
	make -j "${NEOTERM_MAKE_PROCESSES}" install
	popd

	pushd "${NEOTERM_PKG_SRCDIR}"
	echo "./dev.sh build" && ./dev.sh build
	python3 setup.py clean --clean-for-cross-compile --verbose
	popd
}

neoterm_step_pre_configure() {
	neoterm_setup_golang
	CFLAGS+=" $CPPFLAGS"

	sed 's|@NEOTERM_PREFIX@|'"${NEOTERM_PREFIX}"'|g' \
		${NEOTERM_PKG_BUILDER_DIR}/posix-shm.c.in > kitty/posix-shm.c
	cp ${NEOTERM_PKG_BUILDER_DIR}/reallocarray.c glfw/
}

neoterm_step_make() {
	if [[ "${NEOTERM_ON_DEVICE_BUILD}" == "true" ]]; then
		python3 setup.py linux-package \
			--ignore-compiler-warnings \
			--verbose
		return
	fi

	python3 setup.py linux-package \
		--ignore-compiler-warnings \
		--skip-code-generation \
		--verbose
}

neoterm_step_make_install() {
	cp -rT linux-package $NEOTERM_PREFIX
}
