NEOTERM_PKG_HOMEPAGE=https://github.com/letoams/hash-slinger
NEOTERM_PKG_DESCRIPTION="Various tools to generate special DNS records"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.3
NEOTERM_PKG_SRCURL=https://github.com/letoams/hash-slinger/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=e57ba0ae4089b70f4a6fc8ac1edbbd4dd629ad8f8bcff1ff50408a137e170ad9
NEOTERM_PKG_DEPENDS="ca-certificates, gnupg, openssh, python, pyunbound, resolv-conf, swig, python-pip"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PYTHON_TARGET_DEPS="dnspython, ipaddr, m2crypto, python-gnupg"

neoterm_step_make() {
	:
}

neoterm_step_make_install() {
	local f
	for f in openpgpkey sshfp tlsa; do
		install -Dm700 -t $NEOTERM_PREFIX/bin ${f}
		install -Dm600 -t $NEOTERM_PREFIX/share/man/man1 ${f}.1
	done
}

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	echo "Installing dependencies through pip..."
	pip3 install ${NEOTERM_PKG_PYTHON_TARGET_DEPS//, / }
	EOF
}
