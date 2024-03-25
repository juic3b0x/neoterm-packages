NEOTERM_SUBPKG_INCLUDE="
bin/lldb*
include/lldb/
lib/liblldb.so
lib/python${NEOTERM_PYTHON_VERSION}/site-packages
"
NEOTERM_SUBPKG_DESCRIPTION="LLVM-based debugger"
NEOTERM_SUBPKG_DEPENDS="clang, libc++, libedit, libxml2, python, ncurses-ui-libs"
NEOTERM_SUBPKG_BREAKS="lldb-dev, lldb-static"
NEOTERM_SUBPKG_REPLACES="lldb-dev, lldb-static"

# https://github.com/neoterm/neoterm-packages/issues/8880
NEOTERM_SUBPKG_EXCLUDED_ARCHES="arm, i686"
