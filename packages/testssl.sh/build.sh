NEOTERM_PKG_HOMEPAGE=https://testssl.sh/
NEOTERM_PKG_DESCRIPTION="Testing TLS/SSL encryption anywhere on any port."
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.0.8"
NEOTERM_PKG_SRCURL=https://github.com/drwetter/testssl.sh/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=22c5dc6dfc7500db94b6f8a48775f72b5149d0a372b8552ed7666016ee79edf0
NEOTERM_PKG_DEPENDS="bash, ca-certificates, coreutils, curl, gawk, openssl-tool, procps, resolv-conf, socat"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_METHOD=repology
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
NEOTERM_PKG_CONFFILES="
etc/testssl/Apple.pem
etc/testssl/ca_hashes.txt
etc/testssl/cipher-mapping.txt
etc/testssl/client-simulation.txt
etc/testssl/client-simulation.wiresharked.md
etc/testssl/client-simulation.wiresharked.txt
etc/testssl/common-primes.txt
etc/testssl/curves.txt
etc/testssl/Java.pem
etc/testssl/Linux.pem
etc/testssl/Microsoft.pem
etc/testssl/Mozilla.pem
etc/testssl/openssl.cnf
etc/testssl/README.md
etc/testssl/tls_data.txt
"

neoterm_step_make_install() {
	install -Dm 755 -t "$NEOTERM_PREFIX/bin" testssl.sh
	ln -sfr "$NEOTERM_PREFIX/bin/testssl.sh" "$NEOTERM_PREFIX/bin/testssl"
	install -Dm 644 -t "$NEOTERM_PREFIX/etc/testssl" etc/*
	install -Dm 644 -t "$NEOTERM_PREFIX/share/doc/testssl" Readme.md doc/testssl.1.md
	install -Dm 644 doc/testssl.1 "$NEOTERM_PREFIX/share/man/man1/testssl.sh.1"
	ln -sfr "$NEOTERM_PREFIX/share/man/man1/testssl.sh.1" "$NEOTERM_PREFIX/share/man/man1/testssl.1"
}
