NEOTERM_PKG_HOMEPAGE=http://iverilog.icarus.com/
NEOTERM_PKG_DESCRIPTION="Icarus Verilog compiler and simulation tool"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=12.0
NEOTERM_PKG_SRCURL=https://github.com/steveicarus/iverilog/archive/v${NEOTERM_PKG_VERSION/./_}.tar.gz
NEOTERM_PKG_SHA256=a68cb1ef7c017ef090ebedb2bc3e39ef90ecc70a3400afb4aa94303bc3beaa7d
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+_\d+"
NEOTERM_PKG_DEPENDS="libbz2, libc++, readline, zlib"
NEOTERM_PKG_BREAKS="iverilog-dev"
NEOTERM_PKG_REPLACES="iverilog-dev"

neoterm_step_pre_configure() {
	LDFLAGS+=" -lm"
	aclocal
	autoconf
	export CFLAGS+=" -fcommon"

	local _BUILD_LIB=$NEOTERM_PKG_BUILDDIR/_build/lib
	mkdir -p $_BUILD_LIB
	for l in bz2 termcap; do
		echo '!<arch>' > $_BUILD_LIB/lib${l}.a
	done
	export LDFLAGS_FOR_BUILD+=" -L$_BUILD_LIB"
}

neoterm_step_post_configure() {
	find . -name Makefile | xargs -n 1 sed -i \
		-e 's:@EXTRALIBS@::g' \
		-e 's:@MINGW32@:no:g' \
		-e 's:@PICFLAG@:-fPIC:g' \
		-e 's:@install_suffix@::g' \
		-e 's:@rdynamic@:-rdynamic:g' \
		-e 's:@shared@:-shared:g'
}
