NEOTERM_PKG_HOMEPAGE=https://github.com/adriancable/8086tiny
NEOTERM_PKG_DESCRIPTION="A PC XT-compatible emulator/virtual machine"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.25
NEOTERM_PKG_REVISION=4
# Version tag is unavailable.
NEOTERM_PKG_SRCURL=https://github.com/adriancable/8086tiny/archive/c79ca2a34d96931d55ef724c815b289d0767ae3a.tar.gz
NEOTERM_PKG_SHA256=ede246503a745274430fdee77ba639bc133a2beea9f161bff3f7132a03544bf6
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="bash, coreutils, ncurses"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	CPPFLAGS+=" -DNO_GRAPHICS"
}

neoterm_step_make_install() {
	install -Dm700 8086tiny "$NEOTERM_PREFIX"/libexec/8086tiny
	install -Dm600 bios "$NEOTERM_PREFIX"/share/8086tiny/bios.bin
	install -Dm600 fd.img "$NEOTERM_PREFIX"/share/8086tiny/dos.img

	sed -e "s|@NEOTERM_PREFIX@|$NEOTERM_PREFIX|g" \
		-e "s|@PACKAGE_VERSION@|$NEOTERM_PKG_VERSION|g" \
		"$NEOTERM_PKG_BUILDER_DIR"/8086tiny.sh > "$NEOTERM_PREFIX"/bin/8086tiny
	chmod 700 "$NEOTERM_PREFIX"/bin/8086tiny
}
