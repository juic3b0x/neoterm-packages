NEOTERM_PKG_HOMEPAGE=https://freedesktop.org/software/pulseaudio/webrtc-audio-processing/
NEOTERM_PKG_DESCRIPTION="A library containing the AudioProcessing module from the WebRTC project"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="Patrick Gaskin @pgaskin"
NEOTERM_PKG_VERSION=0.3.1
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://freedesktop.org/software/pulseaudio/webrtc-audio-processing/webrtc-audio-processing-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=4dabdd0789acd117d88d53f0a793cf4e906c6a93ee9aa6975ec928eafbf1dfe5
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
