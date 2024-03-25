NEOTERM_PKG_HOMEPAGE=https://github.com/vinceliuice/Fluent-gtk-theme
NEOTERM_PKG_DESCRIPTION="Fluent is a Fluent design theme for GNOME/GTK based desktop environments"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@Yisus7u7 <dev.yisus@hotmail.com>"
NEOTERM_PKG_VERSION=2022.12.15
NEOTERM_PKG_SRCURL=https://github.com/vinceliuice/Fluent-gtk-theme/archive/refs/tags/${NEOTERM_PKG_VERSION//./-}.tar.gz
NEOTERM_PKG_SHA256=0b6865214868057b3e10f90a6ee0b76bd152a72c67642e8fefec549e94410732
NEOTERM_PKG_DEPENDS="gnome-themes-extra, gtk2-engines-murrine, gtk3"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_AUTO_UPDATE=false

neoterm_step_make_install(){
	./install.sh -d ${NEOTERM_PREFIX}/share/themes
}
