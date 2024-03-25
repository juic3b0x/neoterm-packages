NEOTERM_PKG_HOMEPAGE=https://freedesktop.org/Software/shared-mime-info
NEOTERM_PKG_DESCRIPTION="Freedesktop.org Shared MIME Info"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.4"
NEOTERM_PKG_SRCURL=https://gitlab.freedesktop.org/xdg/shared-mime-info/-/archive/${NEOTERM_PKG_VERSION}/shared-mime-info-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=531291d0387eb94e16e775d7e73788d06d2b2fdd8cd2ac6b6b15287593b6a2de
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="coreutils, glib, libxml2"

neoterm_step_create_debscripts() {
	cp "${NEOTERM_PKG_BUILDER_DIR}/postinst" ./postinst
	cp "${NEOTERM_PKG_BUILDER_DIR}/postrm"   ./postrm
	cp "${NEOTERM_PKG_BUILDER_DIR}/triggers" ./triggers
	sed -i "s|@NEOTERM_PREFIX@|$NEOTERM_PREFIX|g" ./{post{inst,rm},triggers}
}
