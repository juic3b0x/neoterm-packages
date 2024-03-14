NEOTERM_PKG_HOMEPAGE=https://github.com/ilai-deutel/kibi
NEOTERM_PKG_DESCRIPTION="A tiny terminal text editor, written in Rust"
NEOTERM_PKG_LICENSE="Apache-2.0, MIT"
NEOTERM_PKG_MAINTAINER="Ilaï Deutel @ilai-deutel"
NEOTERM_PKG_VERSION=0.2.2
NEOTERM_PKG_SRCURL=https://github.com/ilai-deutel/kibi/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=df0e2945d9d08fed3a0adbe73c73405641615eb55835675e06e91411fd541e91
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_make_install() {
    install -Dm644 "config_example.ini" "$NEOTERM_PREFIX/etc/kibi/config.ini"
    install -Dm644 syntax.d/* -t "$NEOTERM_PREFIX/share/kibi/syntax.d"
}
