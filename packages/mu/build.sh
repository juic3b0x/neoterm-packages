NEOTERM_PKG_HOMEPAGE=https://www.djcbsoftware.nl/code/mu/
NEOTERM_PKG_DESCRIPTION="Maildir indexer/searcher and Emacs client (mu4e)"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.10.8"
NEOTERM_PKG_SRCURL=https://github.com/djcb/mu/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=761e074ae4bbf995c93150753be55c8490f3e97c19a31e4289832964a8791bb1
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="emacs, glib, libc++, libxapian, libgmime"

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
		#!$NEOTERM_PREFIX/bin/sh
		echo "(setq byte-compile-warnings nil)" > $NEOTERM_PREFIX/share/emacs/site-lisp/mu4e/nowarnings.el
		LC_ALL=C $NEOTERM_PREFIX/bin/emacs -no-site-file -q -batch -l $NEOTERM_PREFIX/share/emacs/site-lisp/mu4e/nowarnings.el -f batch-byte-compile $NEOTERM_PREFIX/share/emacs/site-lisp/mu4e/*.el
		rm -f $NEOTERM_PREFIX/share/emacs/site-lisp/mu4e/nowarnings.elc
		rm -f $NEOTERM_PREFIX/share/emacs/site-lisp/mu4e/nowarnings.el
		chmod 644 $NEOTERM_PREFIX/share/emacs/site-lisp/mu4e/*.elc
	EOF

	cat <<- EOF > ./prerm
		rm -f $NEOTERM_PREFIX/share/emacs/site-lisp/mu4e/*.elc
	EOF
}
