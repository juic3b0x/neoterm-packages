NEOTERM_PKG_HOMEPAGE=https://pandoc.org/
NEOTERM_PKG_DESCRIPTION="Universal markup converter"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.19.2
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_SKIP_SRC_EXTRACT=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_BLACKLISTED_ARCHES="arm, i686"

neoterm_step_make_install() {
	local srcurl
	local sha256

	case "$NEOTERM_ARCH" in
		aarch64)
			srcurl="https://github.com/jgm/pandoc/releases/download/${NEOTERM_PKG_VERSION}/pandoc-${NEOTERM_PKG_VERSION}-linux-arm64.tar.gz"
			sha256="43f364915b9da64905fc3f6009f5542f224e54fb24f71043ef5154540f1a3983"
			;;
		x86_64)
			srcurl="https://github.com/jgm/pandoc/releases/download/${NEOTERM_PKG_VERSION}/pandoc-${NEOTERM_PKG_VERSION}-linux-amd64.tar.gz"
			sha256="9d55c7afb6a244e8a615451ed9cb02e6a6f187ad4d169c6d5a123fa74adb4830"
			;;
		*)
			neoterm_error_exit "Unsupported arch: $NEOTERM_ARCH"
			;;
	esac

	neoterm_download "$srcurl" "pandoc-${NEOTERM_PKG_VERSION}.tar.gz" "$sha256"
	tar xf "pandoc-${NEOTERM_PKG_VERSION}.tar.gz"
	cd "pandoc-${NEOTERM_PKG_VERSION}"

	install -Dm700 "./bin/pandoc" "$NEOTERM_PREFIX/bin/pandoc"
	install -Dm600 "./share/man/man1/pandoc.1.gz" "$NEOTERM_PREFIX/share/man/man1/pandoc.1.gz"
	install -Dm644 /dev/null "$NEOTERM_PREFIX"/share/bash-completion/completions/pandoc
}

neoterm_step_create_debscripts() {
	cat <<-EOF >./postinst
		#!${NEOTERM_PREFIX}/bin/sh
		pandoc --bash-completion > ${NEOTERM_PREFIX}/share/bash-completion/completions/pandoc
	EOF
}
