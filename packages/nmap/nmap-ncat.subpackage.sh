# FIXME: unsplit and use update-alternatives to provide symlinks and avoid
# the conflict with netcat-openbsd? We do not split nping from nmap package.

NEOTERM_SUBPKG_INCLUDE="bin/ncat share/man/man1/ncat.1.gz"
NEOTERM_SUBPKG_DESCRIPTION="Feature-packed networking utility which reads and writes data across networks from the command line"
NEOTERM_SUBPKG_DEPEND_ON_PARENT=no
NEOTERM_SUBPKG_DEPENDS="liblua54, libpcap, openssl"
NEOTERM_SUBPKG_BREAKS="netcat"
NEOTERM_SUBPKG_REPLACES="netcat"
