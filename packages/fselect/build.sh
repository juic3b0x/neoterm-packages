NEOTERM_PKG_HOMEPAGE=https://github.com/jhspetersson/fselect
NEOTERM_PKG_DESCRIPTION="Find files with SQL-like queries"
NEOTERM_PKG_LICENSE="Apache-2.0, MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.8.5"
NEOTERM_PKG_SRCURL=https://github.com/jhspetersson/fselect/archive/$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=e5742da80606630e310bb1567f2d72d7874f0b2537440e2800507abd786d912d
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_make_install() {
	install -Dm700 \
		"$NEOTERM_PKG_SRCDIR/target/$CARGO_TARGET_NAME"/release/fselect \
		"$NEOTERM_PREFIX"/bin/fselect
}
