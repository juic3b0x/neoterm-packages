NEOTERM_PKG_HOMEPAGE=https://github.com/awesomeWM/awesome
NEOTERM_PKG_DESCRIPTION="A highly configurable, next generation framework window manager for X"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
# Latest release version 4.3 does not support Lua 5.4.
_COMMIT=b54e50ad6cfdcd864a21970b31378f7c64adf3f4
NEOTERM_PKG_VERSION=2023.01.16
NEOTERM_PKG_SRCURL=git+https://github.com/awesomeWM/awesome
NEOTERM_PKG_SHA256=ce0f4ef9105adf1ca04536d60b31dc3aa04cb45e3b1459a63043c34484842ace
NEOTERM_PKG_GIT_BRANCH=master
NEOTERM_PKG_DEPENDS="dbus, gdk-pixbuf, glib, libcairo, liblua54, libx11, libxcb, libxdg-basedir, libxkbcommon, lua-lgi, pango, startup-notification, xcb-util, xcb-util-cursor, xcb-util-keysyms, xcb-util-wm, xcb-util-xrm"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DLUA_MATH_LIBRARY=
"
NEOTERM_PKG_HOSTBUILD=true

neoterm_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT

	local version="$(git log -1 --format=%cs | sed 's/-/./g')"
	if [ "$version" != "$NEOTERM_PKG_VERSION" ]; then
		echo -n "ERROR: The specified version \"$NEOTERM_PKG_VERSION\""
		echo " is different from what is expected to be: \"$version\""
		return 1
	fi

	local s=$(find . -type f ! -path '*/.git/*' -print0 | xargs -0 sha256sum | LC_ALL=C sort | sha256sum)
	if [[ "${s}" != "${NEOTERM_PKG_SHA256}  "* ]]; then
		neoterm_error_exit "Checksum mismatch for source files."
	fi
}

neoterm_step_host_build() {
	local prefix="$NEOTERM_PKG_HOSTBUILD_DIR/_prefix"

	local IMAGEMAGICK_BUILD_SH=$NEOTERM_SCRIPTDIR/packages/imagemagick/build.sh
	local IMAGEMAGICK_SRCURL=$(bash -c ". $IMAGEMAGICK_BUILD_SH; echo \$NEOTERM_PKG_SRCURL")
	local IMAGEMAGICK_SHA256=$(bash -c ". $IMAGEMAGICK_BUILD_SH; echo \$NEOTERM_PKG_SHA256")
	local IMAGEMAGICK_TARFILE=$NEOTERM_PKG_CACHEDIR/$(basename $IMAGEMAGICK_SRCURL)
	neoterm_download $IMAGEMAGICK_SRCURL $IMAGEMAGICK_TARFILE $IMAGEMAGICK_SHA256
	mkdir -p imagemagick
	cd imagemagick
	tar xf $IMAGEMAGICK_TARFILE --strip-components=1
	./configure --prefix="$prefix" --with-png
	make -j $NEOTERM_MAKE_PROCESSES
	make install
}

neoterm_step_pre_configure() {
	export PATH="$NEOTERM_PKG_HOSTBUILD_DIR/_prefix/bin:$PATH"

	local bin="$NEOTERM_PKG_BUILDDIR/_bin"
	mkdir -p "$bin"
	sed -e "s|@PREGEN_DIR@|$NEOTERM_PKG_BUILDER_DIR/pregen|g" \
		"$NEOTERM_PKG_BUILDER_DIR/lua-wrapper.in" > "$bin/lua"
	chmod 0700 "$bin/lua"
	touch "$bin/lgi-check"
	chmod 0700 "$bin/lgi-check"
	export PATH="$bin:$PATH"
}
