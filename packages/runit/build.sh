NEOTERM_PKG_HOMEPAGE=http://smarden.org/runit
NEOTERM_PKG_DESCRIPTION="Tools to provide service supervision and to manage services"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="Henrik Grimler @Grimler91"
NEOTERM_PKG_VERSION=2.1.2
NEOTERM_PKG_REVISION=3
_COMMIT=339dc067c537e36ecb1232f0cfed792ca36c59dd
NEOTERM_PKG_SRCURL=https://git.sr.ht/~grimler/runit/archive/$_COMMIT.tar.gz
NEOTERM_PKG_SHA256=f9f0010329dbdbe9021578f3dd54c11d0cab9489375265a172e1da20ffeb03cf
NEOTERM_PKG_RM_AFTER_INSTALL="
bin/runit
bin/runit-init
share/man/man8/runit.8
share/man/man8/runit-init.8
"

neoterm_step_pre_configure() {
	autoreconf -vfi
}
