NEOTERM_PKG_HOMEPAGE=https://github.com/wwmm/easyeffects
NEOTERM_PKG_DESCRIPTION="Audio effects for PulseAudio applications"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
# Do not upgrade to EasyEffects version.
NEOTERM_PKG_VERSION=4.8.7
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://github.com/wwmm/easyeffects/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=d841f27df87b99747349be6b8de62d131422369908fcb57a81f39590437a8099
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="boost, glib, gst-plugins-bad, gst-plugins-base, gst-plugins-good, gstreamer, gtk3, gtkmm3, libbs2b, libc++, libebur128, librnnoise, libsndfile, libzita-convolver, lilv, pulseaudio"
NEOTERM_PKG_BUILD_DEPENDS="boost-headers, libsamplerate"

neoterm_step_pre_configure() {
	case "$NEOTERM_PKG_VERSION" in
		4.*|*:4.* ) ;;
		* ) neoterm_error_exit "Dubious version '$NEOTERM_PKG_VERSION' for package '$NEOTERM_PKG_NAME'." ;;
	esac

	export BOOST_ROOT=$NEOTERM_PREFIX
}
