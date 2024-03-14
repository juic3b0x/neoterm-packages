NEOTERM_PKG_HOMEPAGE=https://github.com/neoterm/command-not-found
NEOTERM_PKG_DESCRIPTION="Suggest installation of packages in interactive shell sessions"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.4.0
NEOTERM_PKG_REVISION=15
NEOTERM_PKG_SRCURL=https://github.com/neoterm/command-not-found/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=4b7d3684437a33c343a31db00116a3170d24f0cfeebe1f75951b785cf5736aac
NEOTERM_PKG_DEPENDS="libc++"

neoterm_step_pre_configure() {
	export NEOTERM_PREFIX
	export NEOTERM_PKG_CACHEDIR
	neoterm_setup_nodejs

	neoterm_download https://github.com/neoterm/neoterm-packages/raw/master/repo.json \
		$NEOTERM_PKG_CACHEDIR/repo.json SKIP_CHECKSUM
}
