NEOTERM_PKG_HOMEPAGE=https://github.com/karlstav/cava
NEOTERM_PKG_DESCRIPTION="Console-based Audio Visualizer. Works with MPD and Pulseaudio"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="Oliver Schmidhauser @Neo-Oli"
NEOTERM_PKG_VERSION="0.10.1"
NEOTERM_PKG_SRCURL=https://github.com/karlstav/cava/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=a3a60814326fa34b54e93ce0b1e66460d55f1007e576c5152fd47024d9ceaff9
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="fftw, libiniparser, ncurses, pulseaudio"
NEOTERM_PKG_BUILD_DEPENDS="libtool"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	./autogen.sh
}
