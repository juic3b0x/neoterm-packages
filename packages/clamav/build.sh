NEOTERM_PKG_HOMEPAGE=https://www.clamav.net/
NEOTERM_PKG_DESCRIPTION="Anti-virus toolkit for Unix"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.3.0"
NEOTERM_PKG_SRCURL=https://www.clamav.net/downloads/production/clamav-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=0a86a6496320d91576037b33101119af6fd8d5b91060cd316a3a9c229e9604aa
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="json-c, libandroid-support, libbz2, libc++, libcurl, libiconv, libxml2, ncurses, openssl, pcre2, zlib"
NEOTERM_PKG_BREAKS="clamav-dev"
NEOTERM_PKG_REPLACES="clamav-dev"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DAPP_CONFIG_DIRECTORY=$NEOTERM_PREFIX/etc/clamav
-DBYTECODE_RUNTIME=interpreter
-DENABLE_CLAMONACC=OFF
-DENABLE_MILTER=OFF
-DENABLE_TESTS=OFF
-Dtest_run_result=0
-Dtest_run_result__TRYRUN_OUTPUT=
"
NEOTERM_PKG_RM_AFTER_INSTALL="
share/man/man5/clamav-milter.conf.5
share/man/man8/clamav-milter.8
share/man/man8/clamonacc.8
"
NEOTERM_PKG_CONFFILES="
etc/clamav/clamd.conf
etc/clamav/freshclam.conf"

neoterm_step_pre_configure() {
	local _lib="$NEOTERM_PKG_BUILDDIR/_syncfs/lib"
	rm -rf "${_lib}"
	mkdir -p "${_lib}"
	pushd "${_lib}"/..
	$CC $CFLAGS $CPPFLAGS "$NEOTERM_PKG_BUILDER_DIR/syncfs.c" \
		-fvisibility=hidden -c -o ./syncfs.o
	$AR cru "${_lib}"/libsyncfs.a ./syncfs.o
	popd

	LDFLAGS+=" -L${_lib} -l:libsyncfs.a"

	neoterm_setup_rust
	NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" -DRUST_COMPILER_TARGET=$CARGO_TARGET_NAME"
}

neoterm_step_post_make_install() {
	for conf in clamd.conf freshclam.conf; do
		sed "s|@NEOTERM_PREFIX@|$NEOTERM_PREFIX|" \
			"$NEOTERM_PKG_BUILDER_DIR"/$conf.in \
			> "$NEOTERM_PREFIX"/etc/clamav/$conf
	done
	unset conf
}

neoterm_step_post_massage() {
	mkdir -p "$NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX"/var/lib/clamav
	mkdir -p "$NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX"/var/log/clamav
}
