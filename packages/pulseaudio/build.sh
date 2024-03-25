NEOTERM_PKG_HOMEPAGE=https://www.freedesktop.org/wiki/Software/PulseAudio
NEOTERM_PKG_DESCRIPTION="A featureful, general-purpose sound server"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_SRCURL=git+https://github.com/pulseaudio/pulseaudio
NEOTERM_PKG_VERSION="17.0"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_DEPENDS="dbus, libandroid-execinfo, libandroid-glob, libc++, libltdl, libsndfile, libsoxr, libwebrtc-audio-processing, speexdsp"
NEOTERM_PKG_BREAKS="libpulseaudio-dev, libpulseaudio"
NEOTERM_PKG_REPLACES="libpulseaudio-dev, libpulseaudio"
# glib is only a runtime dependency of pulseaudio-glib subpackage
NEOTERM_PKG_BUILD_DEPENDS="libtool, glib, check"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="-D alsa=disabled
-D x11=disabled
-D gtk=disabled
-D openssl=disabled
-D gsettings=disabled
-D doxygen=false
-D database=simple"
NEOTERM_PKG_CONFFILES="etc/pulse/client.conf etc/pulse/daemon.conf etc/pulse/default.pa etc/pulse/system.pa"

neoterm_step_pre_configure() {
	# Our aaudio sink module needs libaaudio.so from a later android api version:
	if [ $NEOTERM_PKG_API_LEVEL -lt 26 ]; then
		local _libdir="$NEOTERM_PKG_TMPDIR/libaaudio"
		rm -rf "${_libdir}"
		mkdir -p "${_libdir}"
		cp "$NEOTERM_STANDALONE_TOOLCHAIN/sysroot/usr/lib/$NEOTERM_HOST_PLATFORM/26/libaaudio.so" \
			"${_libdir}"
		LDFLAGS+=" -L${_libdir}"
	fi

	mkdir $NEOTERM_PKG_SRCDIR/src/modules/sles
	cp $NEOTERM_PKG_BUILDER_DIR/module-sles-sink.c $NEOTERM_PKG_SRCDIR/src/modules/sles
	cp $NEOTERM_PKG_BUILDER_DIR/module-sles-source.c $NEOTERM_PKG_SRCDIR/src/modules/sles
	mkdir $NEOTERM_PKG_SRCDIR/src/modules/aaudio
	cp $NEOTERM_PKG_BUILDER_DIR/module-aaudio-sink.c $NEOTERM_PKG_SRCDIR/src/modules/aaudio

	export LIBS="-landroid-glob -landroid-execinfo"

	local _libgcc="$($CC -print-libgcc-file-name)"
	LIBS+=" -L$(dirname $_libgcc) -l:$(basename $_libgcc)"

	# https://github.com/neoterm/neoterm-packages/issues/18977
	# https://github.com/neoterm/neoterm-packages/issues/18810
	export LDFLAGS+=" -Wl,--undefined-version"
}

neoterm_step_post_make_install() {
	# Some binaries link against these:
	cd $NEOTERM_PREFIX/lib
	for lib in pulseaudio/{,modules/}lib*.so*; do
		ln -v -s -f "$lib" "$(basename "$lib")"
	done

	# Pulseaudio fails to start when it cannot detect any sound hardware
	# so disable hardware detection.
	sed -i $NEOTERM_PREFIX/etc/pulse/default.pa \
		-e '/^load-module module-detect$/s/^/#/'
	echo "load-module module-sles-sink" >> $NEOTERM_PREFIX/etc/pulse/default.pa
	echo "#load-module module-aaudio-sink" >> $NEOTERM_PREFIX/etc/pulse/default.pa
}

neoterm_step_post_massage() {
	# Some programs, e.g. Firefox, try to dlopen(3) `libpulse.so.0`.
	cd ${NEOTERM_PKG_MASSAGEDIR}/${NEOTERM_PREFIX}/lib || exit 1
	if [ ! -e "./libpulse.so.0" ]; then
		ln -sf libpulse.so libpulse.so.0
	fi
}
