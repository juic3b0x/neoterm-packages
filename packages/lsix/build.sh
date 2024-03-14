NEOTERM_PKG_HOMEPAGE=https://github.com/hackerb9/lsix
NEOTERM_PKG_DESCRIPTION="Shows thumbnails in terminal using sixel graphics"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.8.2"
NEOTERM_PKG_SRCURL=https://github.com/hackerb9/lsix/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=79bf81bd66747a9fab1692c52dcda004fe500fbae118dc0a6bdbc6d6aefa20c1
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="bash, imagemagick"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin lsix
}
