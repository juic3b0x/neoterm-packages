NEOTERM_PKG_HOMEPAGE=https://github.com/XAMPPRocky/tokei
NEOTERM_PKG_DESCRIPTION="A blazingly fast CLOC (Count Lines Of Code) program"
NEOTERM_PKG_LICENSE="Apache-2.0, MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="13.0.0-alpha.1"
NEOTERM_PKG_SRCURL=https://github.com/XAMPPRocky/tokei/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=637c6e3d905089f74cf8195666304ac98273cee609541c8a2d87ba438ba08c6e
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--features all"

neoterm_step_post_make_install() {
	install -Dm700 \
		"$NEOTERM_PKG_SRCDIR/target/$CARGO_TARGET_NAME"/release/tokei \
		"$NEOTERM_PREFIX"/bin/tokei
}
