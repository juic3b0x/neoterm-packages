NEOTERM_PKG_HOMEPAGE=https://www.mesa3d.org
NEOTERM_PKG_DESCRIPTION="OpenGL demonstration and test programs"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="Rafael Kitover <rkitover@gmail.com>"
NEOTERM_PKG_VERSION=9.0.0
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://mesa.freedesktop.org/archive/demos/mesa-demos-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=3046a3d26a7b051af7ebdd257a5f23bfeb160cad6ed952329cdff1e9f1ed496b
NEOTERM_PKG_DEPENDS="freeglut, glu, libx11, libxext, opengl"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dlibdrm=disabled
-Dvulkan=disabled
-Dwayland=disabled
-Dwith-system-data-files=true
"

neoterm_step_pre_configure() {
	rm -f configure
}

neoterm_step_post_make_install() {
	local _system_lib=/system/lib
	if [ $NEOTERM_ARCH_BITS = 64 ]; then
		_system_lib+=64
	fi
	# Use LD_LIBRARY_PATH for eglinfo-system
	local _opt_prefix=$NEOTERM_PREFIX/opt/eglinfo-system
	local _libdir=${_opt_prefix}/lib
	mkdir -p ${_libdir} ${_opt_prefix}/bin
	ln -sf ${_system_lib}/libEGL.so ${_libdir}/libEGL.so
	ln -sf libEGL.so ${_libdir}/libEGL.so.1
	rm -rf ${_opt_prefix}/bin/eglinfo
	cp $NEOTERM_PREFIX/bin/eglinfo ${_opt_prefix}/bin/eglinfo
	local _eglinfo_system_script=${_opt_prefix}/bin/eglinfo-system
	rm -rf ${_eglinfo_system_script}
	cat > ${_eglinfo_system_script} <<-EOF
		#!$NEOTERM_PREFIX/bin/sh
		export LD_LIBRARY_PATH=${_libdir}
		exec ${_opt_prefix}/bin/eglinfo "\$@"
	EOF
	chmod 0700 ${_eglinfo_system_script}
	ln -sf ${_eglinfo_system_script} $NEOTERM_PREFIX/bin/eglinfo-system
}

neoterm_step_install_license() {
	install -Dm600 -t $NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME \
		$NEOTERM_PKG_BUILDER_DIR/LICENSE
}
