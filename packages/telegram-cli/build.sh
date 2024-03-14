NEOTERM_PKG_HOMEPAGE=https://github.com/vysheng/tg
NEOTERM_PKG_DESCRIPTION="Telegram messenger CLI"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1:1.4.1
NEOTERM_PKG_REVISION=6
NEOTERM_PKG_DEPENDS="libconfig, libevent, libjansson, openssl, readline, zlib"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--disable-liblua"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_SHA256=45b98f71f5f3421f85ead36b6690585a1a9efe7bc31f3dcd15d485a312f99b26
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_SKIP_SRC_EXTRACT=true
NEOTERM_PKG_HOSTBUILD=true

neoterm_step_get_source() {
	mkdir -p "$NEOTERM_PKG_SRCDIR"
	cd "$NEOTERM_PKG_SRCDIR"
	git clone https://github.com/vysheng/tg
	cd tg
	git checkout 6547c0b21b977b327b3c5e8142963f4bc246187a
	git submodule update --init --recursive
	mv * ../
}

neoterm_step_post_get_source() {
	local s=$(find . -type f ! -path '*/.git/*' -print0 | xargs -0 sha256sum | LC_ALL=C sort | sha256sum)
	if [[ "${s}" != "${NEOTERM_PKG_SHA256}  "* ]]; then
		neoterm_error_exit "Checksum mismatch for source files."
	fi
}

neoterm_step_host_build() {
	cp -rf $NEOTERM_PKG_SRCDIR/* ./
	./configure --disable-liblua
	make bin/generate
	make bin/tl-parser
}

neoterm_step_pre_configure() {
	# avoid duplicated symbol errors
	CFLAGS+=" -fcommon"
}

neoterm_step_post_configure() {
	cp -a $NEOTERM_PKG_HOSTBUILD_DIR/bin ./
	touch -d "next hour" bin/generate bin/tl-parser
	sed -i -e 's@-I/usr/local/include@@g' -e 's@-I/usr/include@@g' Makefile
}

neoterm_step_make_install() {
	install -Dm700 -t "$NEOTERM_PREFIX"/bin/ bin/telegram-cli
	install -Dm600 tg-server.pub "$NEOTERM_PREFIX"/etc/telegram-cli/server.pub
	install -Dm600 -t "$NEOTERM_PREFIX"/share/man/man8/ debian/telegram-cli.8
}
