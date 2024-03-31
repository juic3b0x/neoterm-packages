NEOTERM_PKG_HOMEPAGE=https://www.nongnu.org/synaptic/
NEOTERM_PKG_DESCRIPTION="Synaptic is a graphical package management tool based on GTK+ and APT."
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="Yisus7u7 <dev.yisus@hotmail.com>"
NEOTERM_PKG_VERSION=0.91.3
NEOTERM_PKG_SRCURL=https://github.com/mvo5/synaptic/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=2b943c32c56aca8a133059bae3df01b64b6bb4687b33250d92efb5d6098a606b
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_DEPENDS="apt, dpkg, gdk-pixbuf, glib, gtk3, libc++, libvte, pango"
NEOTERM_PKG_RECOMMENDS="hicolor-icon-theme, netsurf"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure(){
	NOCONFIGURE=1 ./autogen.sh
}


neoterm_step_post_make_install(){
	install -Dm700 -t ${NEOTERM_PREFIX}/bin ./gtk/synaptic
}
