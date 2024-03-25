NEOTERM_PKG_HOMEPAGE=https://asymptote.sourceforge.io/
NEOTERM_PKG_DESCRIPTION="A powerful descriptive vector graphics language for technical drawing"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=(2.86)
NEOTERM_PKG_VERSION+=(0.9.9.8)
NEOTERM_PKG_SRCURL=(https://downloads.sourceforge.net/asymptote/asymptote-${NEOTERM_PKG_VERSION}.src.tgz
                   https://github.com/g-truc/glm/archive/${NEOTERM_PKG_VERSION[1]}.tar.gz)
NEOTERM_PKG_SHA256=(c4ebad1fc3c7b3ce52d89f5fd7e731830d2e6147de7e4c04f8f5cd36cff3c91f
                   7d508ab72cb5d43227a3711420f06ff99b0a0cb63ee2f93631b162bfe1fe9592)
NEOTERM_PKG_DEPENDS="fftw, libc++, libtirpc, zlib"
NEOTERM_PKG_BUILD_DEPENDS="ncurses-static, readline-static"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-gc
"

neoterm_step_post_get_source() {
	mv glm-${NEOTERM_PKG_VERSION[1]} glm
}

neoterm_step_pre_configure() {
	touch GL/glu.h

	local glm_inc=$NEOTERM_PKG_BUILDDIR/_glm/include
	mkdir -p $glm_inc
	cp -r glm/glm $glm_inc/
	CPPFLAGS+=" -I${glm_inc}"
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin asy
	cp -rT base $NEOTERM_PREFIX/share/asymptote
}
