NEOTERM_PKG_HOMEPAGE=https://github.com/Genymobile/scrcpy
NEOTERM_PKG_DESCRIPTION="Provides display and control of Android devices connected via USB or over TCP/IP"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.4"
NEOTERM_PKG_SRCURL=https://github.com/Genymobile/scrcpy/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=60596f6d4c11163083da3e6805666326873ed57f7defd8a20256b928a1d3503b
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="android-tools, ffmpeg, libusb, sdl2"
NEOTERM_PKG_ANTI_BUILD_DEPENDS="android-tools"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dprebuilt_server=$NEOTERM_PKG_SRCDIR/scrcpy-server-v${NEOTERM_PKG_VERSION}
"

neoterm_step_post_get_source() {
	local _url=https://github.com/Genymobile/scrcpy/releases/download/v${NEOTERM_PKG_VERSION}/scrcpy-server-v${NEOTERM_PKG_VERSION}
	neoterm_download ${_url} $(basename ${_url}) SKIP_CHECKSUM
	# We are skipping checksum checking, but we should ensure it is android package.
	[[ "$(file $(basename ${_url}))"==*"Android package"*  || "$(file $(basename ${_url}))"==*"Zip archive data"* ]] \
		|| neoterm_error_exit "$(basename ${_url}) has wrong signature: $(file $(basename ${_url}))"
}
