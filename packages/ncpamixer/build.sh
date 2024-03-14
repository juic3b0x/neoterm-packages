NEOTERM_PKG_HOMEPAGE=https://github.com/fulhax/ncpamixer
NEOTERM_PKG_DESCRIPTION="An ncurses mixer for PulseAudio"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_LICENSE_FILE="../LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.3.7"
NEOTERM_PKG_SRCURL=https://github.com/fulhax/ncpamixer/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=8a647b333875e117449fdfa3167ed50cfebe2c2254ae2618eaa5e64a5e5db3a6
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_DEPENDS="libc++, ncurses-ui-libs, pulseaudio"
NEOTERM_PKG_BUILD_DEPENDS="libandroid-wordexp"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="-DUSE_WIDE=ON"

neoterm_step_pre_configure() {
	NEOTERM_PKG_SRCDIR+="/src"
}
