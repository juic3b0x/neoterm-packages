NEOTERM_PKG_HOMEPAGE=https://git.sr.ht/~emersion/soju
NEOTERM_PKG_DESCRIPTION="A user-friendly IRC bouncer"
NEOTERM_PKG_LICENSE="AGPL-V3"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.7.0"
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://git.sr.ht/~emersion/soju/refs/download/v${NEOTERM_PKG_VERSION}/soju-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=0d776a28bfb2b7f9cdca0336a5debc4888b224812094daf0de0e29bae9c865cf
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="PREFIX=$NEOTERM_PREFIX"

neoterm_step_pre_configure() {
	neoterm_setup_golang

	go mod init || :
	go mod tidy
}

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	mkdir -p $NEOTERM_PREFIX/var/lib/soju
	EOF
}
