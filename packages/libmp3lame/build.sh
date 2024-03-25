NEOTERM_PKG_HOMEPAGE=https://lame.sourceforge.io/
NEOTERM_PKG_DESCRIPTION="High quality MPEG Audio Layer III (MP3) encoder"
NEOTERM_PKG_LICENSE="LGPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.100
NEOTERM_PKG_REVISION=4
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/project/lame/lame/${NEOTERM_PKG_VERSION}/lame-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=ddfe36cab873794038ae2c1210557ad34857a4b6bdc515785d1da9e175b1da1e
NEOTERM_PKG_BREAKS="libmp3lame-dev"
NEOTERM_PKG_REPLACES="libmp3lame-dev"

neoterm_step_post_make_install() {
	local _pkgconfig_dir=$NEOTERM_PREFIX/lib/pkgconfig
	mkdir -p ${_pkgconfig_dir}
	cat <<-EOF > ${_pkgconfig_dir}/lame.pc
		prefix=$NEOTERM_PREFIX
		exec_prefix=\${prefix}
		libdir=\${exec_prefix}/lib
		includedir=\${prefix}/include

		Name: lame
		Description: MP3 encoding library
		Requires:
		Version: $NEOTERM_PKG_VERSION
		Libs: -L\${libdir} -lmp3lame
		Cflags: -I\${includedir}
	EOF
}
