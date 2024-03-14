NEOTERM_SUBPKG_INCLUDE="libexec/scdaemon share/man/man1/scdaemon.1.gz"
NEOTERM_SUBPKG_DESCRIPTION="Daemon invoked by gpg to manage smartcards"
NEOTERM_SUBPKG_DEPENDS="libgcrypt, libksba, libgpg-error, libassuan, libnpth, libusb"
NEOTERM_SUBPKG_CONFLICTS="gnupg (<< 2.3.3-2)"
NEOTERM_SUBPKG_REPLACES="gnupg (<< 2.3.3-2)"
