NEOTERM_PKG_HOMEPAGE=https://github.com/theworkjoy/command-not-found-neoterm
NEOTERM_PKG_DESCRIPTION="Suggest installation of packages in interactive shell sessions"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=v1.0.0
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/theworkjoy/command-not-found-neoterm/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=b13720f1ed6fd49002e7cc2c05bb87132b07394a2303bdf1b5aa9603a25561b4
NEOTERM_PKG_BREAKS="command-not-found"
NEOTERM_PKG_CONFLICTS="command-not-found"
neoterm_step_make_install() {
	make
}

#neoterm_step_pre_configure() {
#	export NEOTERM_PREFIX
#	export NEOTERM_PKG_CACHEDIR
#	neoterm_setup_nodejs
#
#	neoterm_download https://github.com/juic3b0x/neoterm-packages/raw/dev/repo.json \
#		$NEOTERM_PKG_CACHEDIR/repo.json SKIP_CHECKSUM
#}

#neoterm_step_extract_into_massagedir() {
#
#}
