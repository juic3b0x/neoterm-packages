NEOTERM_PKG_HOMEPAGE=https://github.com/patchedsoul/news-flash
NEOTERM_PKG_DESCRIPTION="A modern feed reader designed for the GNOME desktop"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.0.2
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://github.com/patchedsoul/news-flash/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=bc4ce6aa7cd26409d5d9a7ffa539214c9907c7b263eb88f46d8bbab7546fd323
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_DEPENDS="gdk-pixbuf, glib, gtk3, libcairo, libhandy-0.0, libsqlite, libxml2, openssl-1.1, pango, webkit2gtk-4.1"
NEOTERM_PKG_BUILD_DEPENDS="libsoup"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	CPPFLAGS="-I$NEOTERM_PREFIX/include/openssl-1.1 $CPPFLAGS"
	RUSTFLAGS+=" -C link-arg=-Wl,-rpath=$NEOTERM_PREFIX/lib/openssl-1.1"

	NEOTERM_RUST_VERSION=1.52.1
	neoterm_setup_rust
	: "${CARGO_HOME:=$HOME/.cargo}"
	export CARGO_HOME

	cargo fetch --target $CARGO_TARGET_NAME

	local p=$NEOTERM_PKG_BUILDER_DIR/webkit2gtk-sys.diff
	local d
	for d in $CARGO_HOME/registry/src/*/webkit2gtk-sys-*; do
		echo "Applying $(basename ${p}) to $(basename ${d})"
		patch --silent -p1 -d ${d} < ${p} || :
	done

	export RUSTC_BOOTSTRAP=1
	export GETTEXT_DIR=$NEOTERM_PREFIX

	local wrapper_bin=$NEOTERM_PKG_BUILDDIR/_wrapper/bin
	local wrapper_tmp=$NEOTERM_PKG_BUILDDIR/_wrapper/tmp
	rm -rf $wrapper_bin $wrapper_tmp
	mkdir -p $wrapper_bin $wrapper_tmp
	cat <<-EOF > $wrapper_bin/cc
		#!$(command -v sh)
		exec $(command -v cc) -L/usr/lib/x86_64-linux-gnu "\$@"
	EOF
	chmod 0700 $wrapper_bin/cc
	export PATH=$wrapper_bin:$PATH

	local _CARGO_TARGET_LIBDIR=target/$CARGO_TARGET_NAME/release/deps
	mkdir -p $_CARGO_TARGET_LIBDIR
	echo "char *gettext(const char *msgid){return (char *)msgid;}" | \
		$CC $TARGET_CFLAGS -fPIC -x c -c - -o $wrapper_tmp/gettext.o
	local libintl_a=$_CARGO_TARGET_LIBDIR/libintl.a
	rm -rf $libintl_a
	$AR cru $libintl_a $wrapper_tmp/gettext.o
	local lib
	for lib in crypto ssl; do
		ln -s $NEOTERM_PREFIX/lib/openssl-1.1/lib${lib}.so \
			$_CARGO_TARGET_LIBDIR/
	done
}

neoterm_step_configure() {
	sed src/config.rs.in \
		-e 's|@APP_ID@|"com.gitlab.newsflash"|g' \
		-e 's|@VERSION@|"'"$NEOTERM_PKG_VERSION"'"|g' \
		-e 's|@PROFILE@|""|g' \
		> src/config.rs
}

neoterm_step_make() {
	cargo build \
		--jobs $NEOTERM_MAKE_PROCESSES \
		--target $CARGO_TARGET_NAME \
		--release
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin \
		target/${CARGO_TARGET_NAME}/release/news_flash_gtk
}
