NEOTERM_PKG_HOMEPAGE=https://github.com/danmar/cppcheck
NEOTERM_PKG_DESCRIPTION="tool for static C/C++ code analysis"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.13.4"
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_METHOD=repology # Upstream only releases major versions theough GitHub. Other minor updates are released using git tags, better rely on repology for updated versiom
NEOTERM_PKG_SRCURL=https://github.com/danmar/cppcheck/archive/$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=d6ea064ebab76c6aa000795440479767d8d814dd29405918df4c1bbfcd6cb86c
NEOTERM_PKG_DEPENDS="libc++"

# Prevent running dmake during builds. dmake just generates Makefile which we
# aren't using, and QT translation files, but as we are not building the GUI,
# there is no need.  And anyways will lead to "Exec format" error as running
# target binaries on host
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" -DDISABLE_DMAKE=ON"
