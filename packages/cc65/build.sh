NEOTERM_PKG_HOMEPAGE=https://cc65.github.io/
NEOTERM_PKG_DESCRIPTION="A free compiler for 6502 based system"
NEOTERM_PKG_LICENSE="ZLIB"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.19
NEOTERM_PKG_SRCURL=https://github.com/cc65/cc65/archive/refs/tags/V${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=157b8051aed7f534e5093471e734e7a95e509c577324099c3c81324ed9d0de77
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_HOSTBUILD=true

neoterm_step_host_build() {
	cd $NEOTERM_PKG_SRCDIR
	make clean
	make
}

neoterm_step_pre_configure() {
	# hostbuild step have to be run everytime currently
	rm -Rf $NEOTERM_PKG_HOSTBUILD_DIR
}

neoterm_step_make() {
	make clean -C src
	make bin
}

neoterm_pkg_auto_update() {
	local latest_tag="$(neoterm_github_api_get_tag "${NEOTERM_PKG_SRCURL}" newest-tag)"
	[[ -z "${latest_tag}" ]] && neoterm_error_exit "ERROR: Unable to get tag from ${NEOTERM_PKG_SRCURL}"
	neoterm_pkg_upgrade_version "${latest_tag#V}"
}
