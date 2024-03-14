NEOTERM_PKG_HOMEPAGE=https://tigervnc.org/
NEOTERM_PKG_DESCRIPTION="Suite of VNC servers. Based on the VNC 4 branch of TightVNC."
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
# No update anymore. v1.11.x requires support of PAM.
NEOTERM_PKG_VERSION=(1.10.1
		    21.1.8)
NEOTERM_PKG_REVISION=40
NEOTERM_PKG_SRCURL=(https://github.com/TigerVNC/tigervnc/archive/v${NEOTERM_PKG_VERSION}.tar.gz
		   https://xorg.freedesktop.org/releases/individual/xserver/xorg-server-${NEOTERM_PKG_VERSION[1]}.tar.xz)
NEOTERM_PKG_SHA256=(19fcc80d7d35dd58115262e53cac87d8903180261d94c2a6b0c19224f50b58c4
		   38aadb735650c8024ee25211c190bf8aad844c5f59632761ab1ef4c4d5aeb152)
NEOTERM_PKG_DEPENDS="libandroid-shmem, libc++, libgnutls, libjpeg-turbo, libpixman, libx11, libxau, libxdamage, libxdmcp, libxext, libxfixes, libxfont2, opengl, openssl, perl, xkeyboard-config, xorg-xauth, xorg-xkbcomp, zlib"
NEOTERM_PKG_BUILD_DEPENDS="xorg-font-util, xorg-server-xvfb, xorg-util-macros, xorgproto, xtrans"
NEOTERM_PKG_SUGGESTS="aterm, xorg-twm"

NEOTERM_PKG_FOLDERNAME=tigervnc-${NEOTERM_PKG_VERSION}
# Viewer has a separate package tigervnc-viewer. Do not build viewer here.
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="-DBUILD_VIEWER=OFF -DENABLE_NLS=OFF -DENABLE_PAM=OFF -DENABLE_GNUTLS=ON -DFLTK_MATH_LIBRARY="
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_get_source() {
	local p=tigervnc-xserver21-patch.patch
	neoterm_download \
		"https://github.com/TigerVNC/tigervnc/commit/0c5a2b2e7759c2829c07186cfce4d24aa9b5274e.patch" \
		"$NEOTERM_PKG_CACHEDIR/${p}" \
		1fd6858fbc7c67aa3ab82347c5b9dc54e3bb7a9386f373a155acbaca5d8db3c6
	echo "Applying ${p}"
	cat "$NEOTERM_PKG_CACHEDIR/${p}" | patch --silent -p1

	## TigerVNC requires sources of X server (either Xorg or Xvfb).
	cp -r xorg-server-${NEOTERM_PKG_VERSION[1]}/* unix/xserver/

	cd ${NEOTERM_PKG_BUILDDIR}/unix/xserver
	for p in "$NEOTERM_SCRIPTDIR/x11-packages/xorg-server-xvfb"/*.patch; do
		echo "Applying $(basename "${p}")"
		sed -e "s%\@NEOTERM_PREFIX\@%${NEOTERM_PREFIX}%g" \
			-e "s%\@NEOTERM_HOME\@%${NEOTERM_ANDROID_HOME}%g" "$p" \
			| patch --silent -p1
	done

	patch -p1 -i ${NEOTERM_PKG_SRCDIR}/unix/xserver21.1.1.patch
}

neoterm_step_pre_configure() {
	cd ${NEOTERM_PKG_BUILDDIR}/unix/xserver

	autoreconf -fi

	CFLAGS="${CFLAGS/-Os/-Oz} -DFNDELAY=O_NDELAY -DINITARGS=void"
	CPPFLAGS="${CPPFLAGS} -I${NEOTERM_PREFIX}/include/libdrm"
	LDFLAGS="${LDFLAGS} -llog $($CC -print-libgcc-file-name)"

	local xorg_server_xvfb_configure_args="$(. $NEOTERM_SCRIPTDIR/x11-packages/xorg-server-xvfb/build.sh; echo $NEOTERM_PKG_EXTRA_CONFIGURE_ARGS)"
	./configure \
		--host="${NEOTERM_HOST_PLATFORM}" \
		--prefix="${NEOTERM_PREFIX}" \
		--disable-static \
		--disable-nls \
		--enable-debug \
		${xorg_server_xvfb_configure_args}

	LDFLAGS="${LDFLAGS} -landroid-shmem"
}

neoterm_step_post_make_install() {
	cd ${NEOTERM_PKG_BUILDDIR}/unix/xserver
	make -j ${NEOTERM_MAKE_PROCESSES}

	cd ${NEOTERM_PKG_BUILDDIR}/unix/xserver/hw/vnc
	make install

	## use custom variant of vncserver script
	cp -f "${NEOTERM_PKG_BUILDER_DIR}/vncserver" "${NEOTERM_PREFIX}/bin/vncserver"
	sed -i "s|@NEOTERM_PREFIX@|$NEOTERM_PREFIX|g" "${NEOTERM_PREFIX}/bin/vncserver"
}

neoterm_step_post_massage() {
	find lib -name '*.la' -delete
}
