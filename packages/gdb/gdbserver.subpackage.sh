NEOTERM_SUBPKG_INCLUDE="
bin/gdbserver
share/man/man1/gdbserver.*
"
NEOTERM_SUBPKG_DESCRIPTION="The gdbserver program"
NEOTERM_SUBPKG_DEPENDS="libc++, libthread-db"
NEOTERM_SUBPKG_DEPEND_ON_PARENT=no
NEOTERM_SUBPKG_BREAKS="gdb (<< 13.1)"
NEOTERM_SUBPKG_REPLACES="gdb (<< 13.1)"
