NEOTERM_PKG_HOMEPAGE=https://rdiff-backup.net
NEOTERM_PKG_DESCRIPTION="A utility for local/remote mirroring and incremental backups"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.2.6"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/rdiff-backup/rdiff-backup/releases/download/v${NEOTERM_PKG_VERSION/\~/}/rdiff-backup-${NEOTERM_PKG_VERSION/\~/}.tar.gz
NEOTERM_PKG_SHA256=d0778357266bc6513bb7f75a4570b29b24b2760348bbf607babfc3a6f09458cf
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="librsync, python"
NEOTERM_PKG_PYTHON_COMMON_DEPS="wheel"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	continue
}

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	echo "Installing dependencies through pip..."
	pip3 install pyyaml
	EOF
}
