NEOTERM_PKG_HOMEPAGE=https://www.freedesktop.org/wiki/Software/desktop-file-utils
NEOTERM_PKG_DESCRIPTION="Command line utilities for working with desktop entries"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.27"
NEOTERM_PKG_SRCURL=https://www.freedesktop.org/software/desktop-file-utils/releases/desktop-file-utils-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=a0817df39ce385b6621880407c56f1f298168c040c2032cedf88d5b76affe836
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="glib"

neoterm_step_create_debscripts() {
	for i in postinst postrm triggers; do
		sed \
			"s|@NEOTERM_PREFIX@|${NEOTERM_PREFIX}|g" \
			"${NEOTERM_PKG_BUILDER_DIR}/hooks/${i}.in" > ./${i}
		chmod 755 ./${i}
	done
	unset i
	chmod 644 ./triggers
}
