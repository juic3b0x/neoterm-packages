NEOTERM_PKG_HOMEPAGE=https://www.qcustomplot.com/
NEOTERM_PKG_DESCRIPTION="A Qt C++ widget for plotting and data visualization"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.1.1
NEOTERM_PKG_SRCURL=(https://www.qcustomplot.com/release/${NEOTERM_PKG_VERSION}/QCustomPlot-source.tar.gz
                   https://www.qcustomplot.com/release/${NEOTERM_PKG_VERSION}/QCustomPlot-sharedlib.tar.gz)
NEOTERM_PKG_SHA256=(5e2d22dec779db8f01f357cbdb25e54fbcf971adaee75eae8d7ad2444487182f
                   35d6ea9c7e8740edf0b37e2cb6aa6794150d0dde2541563e493f3f817012b4c0)
NEOTERM_PKG_DEPENDS="libc++, qt5-qtbase"
NEOTERM_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
CONFIG+=shared
"

neoterm_step_pre_configure() {
	NEOTERM_PKG_SRCDIR+="/qcustomplot-sharedlib/sharedlib-compilation"
	NEOTERM_PKG_BUILDDIR="$NEOTERM_PKG_SRCDIR"
}

neoterm_step_configure() {
	"${NEOTERM_PREFIX}/opt/qt/cross/bin/qmake" \
		-spec "${NEOTERM_PREFIX}/lib/qt/mkspecs/neoterm-cross" \
		${NEOTERM_PKG_EXTRA_CONFIGURE_ARGS}
}

neoterm_step_make_install() {
	local f
	for f in libqcustomplot.so*; do
		if test -L "${f}"; then
			ln -sf "$(readlink "${f}")" $NEOTERM_PREFIX/lib/"${f}"
		else
			install -Dm600 -t $NEOTERM_PREFIX/lib "${f}"
		fi
	done
	install -Dm600 -t $NEOTERM_PREFIX/include ../../qcustomplot.h
}
