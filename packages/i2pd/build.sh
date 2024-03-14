NEOTERM_PKG_HOMEPAGE=https://i2pd.website/
NEOTERM_PKG_DESCRIPTION="A full-featured C++ implementation of the I2P router"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_LICENSE_FILE="../LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.50.2"
NEOTERM_PKG_SRCURL=https://github.com/PurpleI2P/i2pd/archive/$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=ae2ec4732c38fda71b4b48ce83624dd8b2e05083f2c94a03d20cafb616f63ca5
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="boost, libc++, miniupnpc, openssl, zlib"
NEOTERM_PKG_BUILD_DEPENDS="boost-headers"
NEOTERM_PKG_FORCE_CMAKE=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="-DWITH_UPNP:BOOL=ON"
NEOTERM_PKG_RM_AFTER_INSTALL="src"

NEOTERM_PKG_CONFFILES="
etc/i2pd/i2pd.conf
etc/i2pd/tunnels.conf
"

neoterm_step_pre_configure() {
	NEOTERM_PKG_SRCDIR+="/build"
	CXXFLAGS="${CXXFLAGS/-Oz/-O2}"
}

neoterm_step_post_make_install() {
	cd $NEOTERM_PKG_SRCDIR/../

	install -Dm600 -t "$NEOTERM_PREFIX"/etc/i2pd \
		./contrib/i2pd.conf \
		./contrib/tunnels.conf

	local _file _dir
	while read -r -d '' _file; do
		_dir="${_file#contrib/certificates}"
		_dir="${_dir%/*}"
		install -Dm600 "$_file" -t "${NEOTERM_PREFIX}/share/i2pd/certificates/${_dir}"
	done < <(find contrib/certificates -type f -print0)

	install -Dm600 -t "${NEOTERM_PREFIX}"/share/doc/i2pd/tunnels.d \
		./contrib/tunnels.d/README \
		./contrib/tunnels.d/IRC-Ilita.conf \
		./contrib/tunnels.d/IRC-Irc2P.conf

	install -Dm600 -t "${NEOTERM_PREFIX}"/share/man/man1 ./debian/i2pd.1
}
