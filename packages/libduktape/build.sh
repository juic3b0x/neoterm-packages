NEOTERM_PKG_HOMEPAGE=https://www.duktape.org/
NEOTERM_PKG_DESCRIPTION="An embeddable Javascript engine with a focus on portability and compact footprint"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.7.0
NEOTERM_PKG_SRCURL=https://github.com/svaarala/duktape/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=fde9a11e816cf06ccc1da5d85e2d15d62eace6122c8177bcee18ce042a649cdc
NEOTERM_PKG_REPLACES="duktape (<< 2.3.0-1), libduktape-dev"
NEOTERM_PKG_BREAKS="duktape (<< 2.3.0-1), libduktape-dev"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	# configure.py requires 'yaml' python2 module.
	if ! pip2 show pyyaml > /dev/null 2>&1; then
		pip2 install pyyaml
	fi
}

neoterm_step_make() {
	make libduktape.so.1.0.0 duk CC=${CC} GXX=${CXX}
}

neoterm_step_make_install() {
	install libduktape.so.1.0.0 ${NEOTERM_PREFIX}/lib/libduktape.so
	install duk ${NEOTERM_PREFIX}/bin
	install prep/nondebug/*.h ${NEOTERM_PREFIX}/include
}

neoterm_step_post_make_install() {
	# Add a pkg-config file for the duktape lib
	local pkgconfig_dir="$NEOTERM_PREFIX/lib/pkgconfig"
	mkdir -p "${pkgconfig_dir}"
	cat > "${pkgconfig_dir}/duktape.pc" <<-HERE
		Name: Duktape
		Description: Shared library for the Duktape interpreter
		Version: $NEOTERM_PKG_VERSION
		Requires:
		Libs: -lduktape -lm
	HERE
}
