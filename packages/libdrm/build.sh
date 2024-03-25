NEOTERM_PKG_HOMEPAGE=https://dri.freedesktop.org/wiki/
NEOTERM_PKG_DESCRIPTION="Userspace interface to kernel DRM services"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.4.120"
NEOTERM_PKG_SRCURL=https://dri.freedesktop.org/libdrm/libdrm-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=3bf55363f76c7250946441ab51d3a6cc0ae518055c0ff017324ab76cdefb327a
NEOTERM_PKG_AUTO_UPDATE=true

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dintel=disabled
-Dradeon=disabled
-Damdgpu=disabled
-Dnouveau=disabled
-Dvmwgfx=disabled
-Dtests=false
"

neoterm_step_pre_configure() {
	CFLAGS="${CFLAGS} -DANDROID"
}

neoterm_step_install_license() {
	install -Dm600 -t $NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME \
		$NEOTERM_PKG_BUILDER_DIR/LICENSE
}
