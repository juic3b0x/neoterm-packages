NEOTERM_PKG_HOMEPAGE=https://github.com/cantino/mcfly
NEOTERM_PKG_DESCRIPTION="Replaces your default ctrl-r shell history search with an intelligent search engine"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.8.4"
NEOTERM_PKG_SRCURL=https://github.com/cantino/mcfly/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=637f50756366604d4d19a6f623cfd490c38e1b971708ec8ccdb39887a0e9c1f1
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_pre_configure() {
	if [ "$NEOTERM_ARCH" == "x86_64" ]; then
		local libdir=target/x86_64-linux-android/release/deps
		mkdir -p $libdir
		pushd $libdir
		RUSTFLAGS+=" -C link-arg=$($CC -print-libgcc-file-name)"
		echo "INPUT(-l:libunwind.a)" > libgcc.so
		popd
	fi
}

neoterm_step_make() {
	neoterm_setup_rust
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/mcfly
	install -Dm600 -t $NEOTERM_PREFIX/share/mcfly mcfly.{fi,z}sh
}

neoterm_step_create_debscripts() {
	cat <<-EOF > ./postinst
		#!$NEOTERM_PREFIX/bin/sh
		echo
		echo "********"
		echo "McFly does not support Bash on Android."
		echo
		echo "https://github.com/neoterm/neoterm-packages/issues/8722"
		echo "https://github.com/cantino/mcfly/issues/215"
		echo "********"
		echo
	EOF
}
