NEOTERM_PKG_HOMEPAGE=http://point-at-infinity.org/seccure/
NEOTERM_PKG_DESCRIPTION="SECCURE Elliptic Curve Crypto Utility for Reliable Encryption"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.5
NEOTERM_PKG_REVISION=7
NEOTERM_PKG_SRCURL=http://point-at-infinity.org/seccure/seccure-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=6566ce4afea095f83690b93078b910ca5b57b581ebc60e722f6e3fe8e098965b
NEOTERM_PKG_DEPENDS="libgcrypt"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	make seccure-key
}

neoterm_step_make_install() {
	install -Dm700 seccure-key "$NEOTERM_PREFIX"/bin/
	install -Dm600 seccure.1 "$NEOTERM_PREFIX"/share/man/man1/

	for i in encrypt decrypt sign verify signcrypt veridec dh; do
		ln -sfr "$NEOTERM_PREFIX"/bin/seccure-key "$NEOTERM_PREFIX"/bin/seccure-${i}
		ln -sfr "$NEOTERM_PREFIX"/share/man/man1/seccure.1 "$NEOTERM_PREFIX"/share/man/man1/seccure-${i}.1
	done
	unset i
}
