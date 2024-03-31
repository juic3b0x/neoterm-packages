NEOTERM_PKG_HOMEPAGE=https://github.com/stevenhoneyman/l3afpad
NEOTERM_PKG_DESCRIPTION="Simple text editor forked from Leafpad, supports GTK+ 3.x"
NEOTERM_PKG_MAINTAINER="Yisus7u7 <dev.yisus@hotmail.com>"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_VERSION=0.8.18.1.11
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://github.com/stevenhoneyman/l3afpad/archive/refs/tags/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=86f374b2f950b7c60dda50aa80a5034b8e3c80ded5cd3284c2d5921b31652793
NEOTERM_PKG_DEPENDS="gtk3"

neoterm_step_pre_configure() {
	./autogen.sh
}
