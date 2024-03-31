NEOTERM_PKG_HOMEPAGE=https://godotengine.org
NEOTERM_PKG_DESCRIPTION="Advanced cross-platform 2D and 3D game engine"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=4.2.1
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/godotengine/godot/archive/$NEOTERM_PKG_VERSION-stable.tar.gz
NEOTERM_PKG_SHA256=716cfd489dbfc91b5e04cc0df8be415ba6eec74c5fb471840275d887cb53ff95
NEOTERM_PKG_DEPENDS="ca-certificates, glu, libandroid-execinfo, libc++, libenet, libogg, libtheora, libvorbis, libvpx, libwebp, libwslay, libxcursor, libxi, libxinerama, libxkbcommon, libxrandr, mbedtls, miniupnpc, opengl, opusfile, pcre2, speechd, zstd, fontconfig"
NEOTERM_PKG_BUILD_DEPENDS="pulseaudio, yasm"
NEOTERM_PKG_PYTHON_COMMON_DEPS="scons"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	local to_unbundle="libogg libtheora libvorbis libvpx libwebp mbedtls miniupnpc opus pcre2 wslay zstd enet"
	local system_libs=""
	for _lib in $to_unbundle; do
		rm -fr thirdparty/$_lib
		system_libs+="builtin_"$_lib"=no "
	done

	local _ARCH
	case $NEOTERM_ARCH in
		aarch64) _ARCH=arm64;;
		arm) _ARCH=arm32;;
		x86_64) _ARCH=x86_64;;
		i686) _ARCH=x86_32;;
	esac

	export BUILD_NAME=neoterm
	scons -j$NEOTERM_MAKE_PROCESSES \
		use_static_cpp=no \
		colored=yes \
		platform=linuxbsd \
		alsa=no \
		execinfo=yes \
		pulseaudio=yes \
		udev=no \
		arch=$_ARCH \
		system_certs_path=$NEOTERM_PREFIX/etc/tls/cert.pem \
		use_llvm=yes \
		AR="$(command -v $AR)" \
		CC="$(command -v $CC)" \
		CXX="$(command -v $CXX)" \
		OBJCOPY="$(command -v $OBJCOPY)" \
		STRIP="$(command -v $STRIP)" \
		CFLAGS="$CPPFLAGS $CFLAGS" \
		CXXFLAGS="$CPPFLAGS $CXXFLAGS" \
		LINKFLAGS="$LDFLAGS" \
		CPPPATH="$NEOTERM_PREFIX/include" \
		LIBPATH="$NEOTERM_PREFIX/lib" \
		$system_libs \
		verbose=1

	mv $NEOTERM_PKG_BUILDDIR/bin/godot.linuxbsd.editor.$_ARCH.llvm $NEOTERM_PKG_BUILDDIR/bin/godot.linuxbsd.editor.llvm
}

neoterm_step_make_install() {
	install -Dm644 misc/dist/linux/org.godotengine.Godot.desktop $NEOTERM_PREFIX/share/applications/godot.desktop
	install -Dm644 icon.svg $NEOTERM_PREFIX/share/pixmaps/godot.svg
	install -Dm644 LICENSE.txt $NEOTERM_PREFIX/share/licenses/godot/LICENSE
	install -Dm755 $NEOTERM_PKG_BUILDDIR/bin/godot.linuxbsd.editor.llvm $NEOTERM_PREFIX/bin/godot
	install -Dm644 $NEOTERM_PKG_BUILDDIR/misc/dist/linux/godot.6 $NEOTERM_PREFIX/share/man/man6/godot.6
	install -Dm644 $NEOTERM_PKG_BUILDDIR/misc/dist/linux/org.godotengine.Godot.xml $NEOTERM_PREFIX/share/mime/packages/org.godotengine.Godot.xml
}
