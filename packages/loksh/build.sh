NEOTERM_PKG_HOMEPAGE=https://github.com/dimkr/loksh
NEOTERM_PKG_DESCRIPTION="A Linux port of OpenBSD's ksh"
NEOTERM_PKG_LICENSE="Public Domain"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="7.4"
NEOTERM_PKG_SRCURL=git+https://github.com/dimkr/loksh
NEOTERM_PKG_GIT_BRANCH=$NEOTERM_PKG_VERSION
NEOTERM_PKG_DEPENDS="ncurses"

neoterm_step_post_get_source() {
	pushd subprojects/lolibc
	mv include _include_lolibc
	mkdir include
	mv _include_lolibc include/lolibc
	pushd include/lolibc
	local _LOLIBC_HEADERS=$(find * -name '*.h')
	popd
	popd
	local f
	for f in $(find . -name '*.[ch]'); do
		local h
		for h in ${_LOLIBC_HEADERS}; do
			sed -i "s:#include <${h//./\\.}>:#include <lolibc/${h}>:g" ${f}
		done
	done
	cd subprojects/lolibc/include/lolibc
	for f in ${_LOLIBC_HEADERS}; do
		sed -i "s:#include_next :#include :g" ${f}
	done

	CFLAGS+=" -D__USE_GNU"
}
