NEOTERM_SUBPKG_INCLUDE="
bin/as
bin/elfedit
bin/gprof
bin/ld.bfd
libexec/binutils/
share/info/as.info
share/info/binutils.info
share/info/gprof.info
share/info/ld.info
share/man/
"
NEOTERM_SUBPKG_DESCRIPTION="Collection of binary tools, the main ones being ld, the GNU linker, and as, the GNU assembler"
NEOTERM_SUBPKG_DEPENDS="libc++"
NEOTERM_SUBPKG_BREAKS="binutils (<< 2.39-3)"
NEOTERM_SUBPKG_REPLACES="binutils (<< 2.39-3)"
