NEOTERM_PKG_HOMEPAGE=https://tinyproxy.github.io/
NEOTERM_PKG_DESCRIPTION="Light-weight HTTP proxy daemon for POSIX operating systems"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.11.1
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/tinyproxy/tinyproxy/releases/download/${NEOTERM_PKG_VERSION}/tinyproxy-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=d66388448215d0aeb90d0afdd58ed00386fb81abc23ebac9d80e194fceb40f7c
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--disable-regexcheck"

neoterm_step_pre_configure() {
	CPPFLAGS+=" -DLINE_MAX=_POSIX2_LINE_MAX"
}

neoterm_step_post_massage() {
	mkdir -p "${NEOTERM_PKG_MASSAGEDIR}/${NEOTERM_PREFIX}/var/log/${NEOTERM_PKG_NAME}"
	mkdir -p "${NEOTERM_PKG_MASSAGEDIR}/${NEOTERM_PREFIX}/var/run/${NEOTERM_PKG_NAME}"
}
