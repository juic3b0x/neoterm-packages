NEOTERM_PKG_HOMEPAGE=https://github.com/vinceliuice/Fluent-icon-theme
NEOTERM_PKG_DESCRIPTION="Fluent icon theme for linux desktops"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@Yisus7u7 <dev.yisus@hotmail.com>"
NEOTERM_PKG_VERSION=2023.06.07
NEOTERM_PKG_SRCURL=https://github.com/vinceliuice/Fluent-icon-theme/archive/${NEOTERM_PKG_VERSION//./-}.tar.gz
NEOTERM_PKG_SHA256=69d2502aa9411ddae0082e623d7a86e856c63653638036498d7fffad10f8208e
NEOTERM_PKG_DEPENDS="hicolor-icon-theme"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_RM_AFTER_INSTALL="share/icons/*/icon-theme.cache"
NEOTERM_PKG_AUTO_UPDATE=false

neoterm_step_make_install(){
	./install.sh -d ${NEOTERM_PREFIX}/share/icons -r
}
