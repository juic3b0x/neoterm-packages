NEOTERM_PKG_HOMEPAGE=https://dev.maxmind.com/geoip/geoip2/geolite2/
NEOTERM_PKG_DESCRIPTION="GeoLite2 IP geolocation databases compiled by MaxMind"
NEOTERM_PKG_LICENSE="CC0-1.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_BUILD_IN_SRC=true

# MaxMind removed databases from public access:
# https://blog.maxmind.com/2019/12/18/significant-changes-to-accessing-and-using-geolite2-databases/
# Reusing files from the our last build (2019.12.21).
NEOTERM_PKG_VERSION=20191221
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://github.com/juic3b0x/distfiles/releases/download/2021.01.04/geolite2-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=7afd73d90325d4a8aa3707c0c4a34f89a4b469fe43b4f3a3d69da23884af1e70

neoterm_step_make_install() {
	install -Dm600 \
		-t "$NEOTERM_PREFIX"/share/GeoIP/ \
		"${NEOTERM_PKG_SRCDIR}"/GeoLite2-{ASN,Country,City}.mmdb
}
