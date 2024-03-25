NEOTERM_PKG_HOMEPAGE=https://openvpn.net/easyrsa.html
NEOTERM_PKG_DESCRIPTION="Simple shell based CA utility"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER='Vishal Biswas @vishalbiswas'
NEOTERM_PKG_VERSION=3.0.1
NEOTERM_PKG_DEPENDS="openssl-tool"
NEOTERM_PKG_SRCURL=https://github.com/OpenVPN/easy-rsa/releases/download/$NEOTERM_PKG_VERSION/EasyRSA-$NEOTERM_PKG_VERSION.tgz
NEOTERM_PKG_SHA256=dbdaf5b9444b99e0c5221fd4bcf15384c62380c1b63cea23d42239414d7b2d4e
NEOTERM_PKG_CONFFILES="etc/easy-rsa/openssl-1.0.cnf, etc/easy-rsa/vars"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make_install() {
    install -D -m0755 easyrsa "${NEOTERM_PREFIX}"/bin/easyrsa

    install -D -m0644 openssl-1.0.cnf "${NEOTERM_PREFIX}"/etc/easy-rsa/openssl-1.0.cnf
    install -D -m0644 vars.example "${NEOTERM_PREFIX}"/etc/easy-rsa/vars
    install -d -m0755 "${NEOTERM_PREFIX}"/etc/easy-rsa/x509-types/
    install -m0644 x509-types/* "${NEOTERM_PREFIX}"/etc/easy-rsa/x509-types/
}
