NEOTERM_PKG_HOMEPAGE=https://dev.yorhel.nl/ncdu
NEOTERM_PKG_DESCRIPTION="Disk usage analyzer"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_LICENSE_FILE="LICENSES/MIT.txt"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.3"
NEOTERM_PKG_SRCURL=https://dev.yorhel.nl/download/ncdu-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=bbce1d1c70f1247671be4ea2135d8c52cd29a708af5ed62cecda7dc6a8000a3c
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_get_source() {
	# TODO drop all this once figure out how zig can work with bionic libc
	local NCURSES_SRCURL=$(. "${NEOTERM_SCRIPTDIR}"/packages/ncurses/build.sh; echo ${NEOTERM_PKG_SRCURL[0]})
	local NCURSES_SHA256=$(. "${NEOTERM_SCRIPTDIR}"/packages/ncurses/build.sh; echo ${NEOTERM_PKG_SHA256[0]})

	rm -fr ncurses-* ncurses
	neoterm_download "${NCURSES_SRCURL}" "${NEOTERM_PKG_CACHEDIR}/ncurses.tar.gz" "${NCURSES_SHA256}"
	tar -xf "${NEOTERM_PKG_CACHEDIR}/ncurses.tar.gz"
	mv -v ncurses-* ncurses

	echo "INFO: Applying patches from packages/ncurses"
	for p in "${NEOTERM_SCRIPTDIR}"/packages/ncurses/*.patch; do
	patch -p1 -i "${p}" -d ncurses
	done

	local f=$(sed -nE "s|.*SPDX-FileCopyrightText.*: (.*)|\1|p" ChangeLog)
	sed \
		-e "s|<year> <copyright holders>|${f}|" \
		-i LICENSES/MIT.txt
	sed \
		-e "s|--with-default-terminfo-dir=/usr|--with-default-terminfo-dir=${NEOTERM_PREFIX}|" \
		-i Makefile
}

neoterm_step_pre_configure() {
	neoterm_setup_zig
	unset CFLAGS LDFLAGS
}

neoterm_step_make() {
	make -j "${NEOTERM_MAKE_PROCESSES}" static-${ZIG_TARGET_NAME}.tar.gz
}

neoterm_step_make_install() {
	# allow ncdu2 to co-exist with ncdu
	tar -xf static-${ZIG_TARGET_NAME}.tar.gz
	mv -v ncdu ncdu2
	mv -v ncdu.1 ncdu2.1
	install -Dm755 -t "${NEOTERM_PREFIX}/bin" ncdu2
	install -Dm644 -t "${NEOTERM_PREFIX}/share/man/man1" ncdu2.1
}
