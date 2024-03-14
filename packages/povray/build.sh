NEOTERM_PKG_HOMEPAGE=https://www.povray.org/
NEOTERM_PKG_DESCRIPTION="The Persistence of Vision Raytracer"
NEOTERM_PKG_LICENSE="AGPL-V3"
NEOTERM_PKG_MAINTAINER="@neoterm"
_POVRAY_VERSION_BASE=3.8
NEOTERM_PKG_VERSION=${_POVRAY_VERSION_BASE}.0-beta.2
NEOTERM_PKG_REVISION=10
NEOTERM_PKG_SRCURL=https://github.com/POV-Ray/povray/releases/download/v${NEOTERM_PKG_VERSION}/povunix-v${NEOTERM_PKG_VERSION}-src.tar.gz
NEOTERM_PKG_SHA256=4717c9bed114deec47cf04a8175cc4060dafc159f26e7896480a60f4411ca5ad
NEOTERM_PKG_DEPENDS="boost, imath, libc++, libjpeg-turbo, libpng, libtiff, openexr, povray-data, zlib"
NEOTERM_PKG_BUILD_DEPENDS="boost-headers"
NEOTERM_PKG_RM_AFTER_INSTALL="
share/doc/povray-*/html
"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-debug
--disable-dependency-tracking
--disable-optimiz
--disable-optimiz-arch
--disable-strip
--enable-io-restrictions
--with-boost=$NEOTERM_PREFIX/lib
--with-boost-libdir=$NEOTERM_PREFIX/lib
--without-libmkl
--without-libsdl
--without-x
ax_cv_c_compiler_vendor=clang
ax_cv_cxx_compiler_vendor=clang
COMPILED_BY=Termux
"

neoterm_step_pre_configure() {
	# Fast is justice.
	CFLAGS+=" -Ofast"
	CXXFLAGS+=" -Ofast"
}

neoterm_step_create_debscripts() {
	echo "#!$NEOTERM_PREFIX/bin/sh" > postinst
	echo "povconfuser=\$HOME/.povray/${_POVRAY_VERSION_BASE}" >> postinst
	echo "mkdir -p \$povconfuser/" >> postinst
	echo "for f in povray.conf povray.ini; do" >> postinst
	echo "    if [ ! -f \$povconfuser/\$f ]; then" >> postinst
	echo "        cp \$NEOTERM_PREFIX/etc/povray/${_POVRAY_VERSION_BASE}/\$f \$povconfuser/" >> postinst
	echo "    fi" >> postinst
	echo "done" >> postinst
	echo "exit 0" >> postinst
	chmod 0755 postinst
}
