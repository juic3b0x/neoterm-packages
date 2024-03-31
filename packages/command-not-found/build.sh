NEOTERM_PKG_HOMEPAGE=https://github.com/juic3b0x/command-not-found
NEOTERM_PKG_DESCRIPTION="Suggest installation of packages in interactive shell sessions"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.4.0
NEOTERM_PKG_REVISION=16
NEOTERM_PKG_SRCURL=https://github.com/juic3b0x/command-not-found/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=923d3679588c812537e1f1018630ddf810b6aff26186692b8cc2aae117e40538
NEOTERM_PKG_DEPENDS="libc++"

neoterm_step_pre_configure() {
	export NEOTERM_PREFIX
	export NEOTERM_PKG_CACHEDIR
	neoterm_setup_nodejs

	neoterm_download https://github.com/juic3b0x/neoterm-packages/raw/dev/repo.json \
		$NEOTERM_PKG_CACHEDIR/repo.json SKIP_CHECKSUM
}
