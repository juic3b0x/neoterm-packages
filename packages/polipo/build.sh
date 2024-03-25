NEOTERM_PKG_HOMEPAGE=http://www.pps.jussieu.fr/~jch/software/polipo/
NEOTERM_PKG_DESCRIPTION="A small and fast caching web proxy"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.1.1
NEOTERM_PKG_SRCURL=http://www.pps.univ-paris-diderot.fr/~jch/software/files/polipo/polipo-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=a259750793ab79c491d05fcee5a917faf7d9030fb5d15e05b3704e9c9e4ee015
NEOTERM_PKG_DEPENDS="resolv-conf"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_CONFFILES="etc/polipo/config"

neoterm_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS"
}

neoterm_step_post_make_install() {
	install -Dm600 config.sample "$NEOTERM_PREFIX"/etc/polipo/config.sample
	install -Dm600 forbidden.sample "$NEOTERM_PREFIX"/etc/polipo/forbidden.sample
	install -Dm600 "$NEOTERM_PKG_BUILDER_DIR"/neoterm.config \
		"$NEOTERM_PREFIX"/etc/polipo/config
}

neoterm_step_post_massage() {
	mkdir -p "$NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX"/var/cache/polipo
}
