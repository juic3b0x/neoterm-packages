NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/recutils/
NEOTERM_PKG_DESCRIPTION="Set of tools and libraries to access human-editable, plain text databases called recfiles"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="Rowan Wookey <admin@rwky.net>"
NEOTERM_PKG_VERSION=1.9
NEOTERM_PKG_SRCURL=https://ftp.gnu.org/gnu/recutils/recutils-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=6301592b0020c14b456757ef5d434d49f6027b8e5f3a499d13362f205c486e0e
# Prevent libandroid-spawn from being picked up
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_header_spawn_h=no"
NEOTERM_PKG_EXTRA_MAKE_ARGS="lispdir=${NEOTERM_PREFIX}/share/emacs/site-lisp"
