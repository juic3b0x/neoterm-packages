NEOTERM_PKG_HOMEPAGE=https://thrysoee.dk/editline/
NEOTERM_PKG_DESCRIPTION="Library providing line editing, history, and tokenization functions"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=20221030-3.1
NEOTERM_PKG_SRCURL=https://thrysoee.dk/editline/libedit-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=f0925a5adf4b1bf116ee19766b7daa766917aec198747943b1c4edf67a4be2bb
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="libandroid-support, ncurses"
NEOTERM_PKG_BREAKS="libedit-dev"
NEOTERM_PKG_REPLACES="libedit-dev"
NEOTERM_PKG_RM_AFTER_INSTALL="share/man/man7/editline.7 share/man/man3/history.3"

neoterm_step_pre_configure() {
	CFLAGS+=" -D__STDC_ISO_10646__=201103L -DNBBY=CHAR_BIT"
}
