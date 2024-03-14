# Not making sense on Termux which is essentially a single-user environment.
NEOTERM_PKG_HOMEPAGE=https://savannah.gnu.org/projects/acct/
NEOTERM_PKG_DESCRIPTION="GNU Accounting Utilities"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=6.6.4
NEOTERM_PKG_SRCURL=https://ftp.gnu.org/gnu/acct/acct-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=4c15bf2b58b16378bcc83f70e77d4d40ab0b194acf2ebeefdb507f151faa663f

neoterm_step_pre_configure() {
	autoreconf -fi
}

neoterm_step_post_massage() {
	mkdir -p ./var/account
}
