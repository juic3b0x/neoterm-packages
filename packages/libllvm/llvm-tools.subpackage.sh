NEOTERM_SUBPKG_INCLUDE="
bin/FileCheck
bin/UnicodeNameMappingGenerator
bin/count
bin/lli-child-target
bin/llvm-PerfectShuffle
bin/llvm-jitlink-executor
bin/not
bin/obj2yaml
bin/yaml-bench
bin/yaml2obj
share/man/man1/FileCheck.1.gz
"
NEOTERM_SUBPKG_DESCRIPTION="LLVM Development Tools"
NEOTERM_SUBPKG_DEPENDS="libc++, ncurses, zlib"
NEOTERM_SUBPKG_BREAKS="libllvm (<< 16.0.0)"
NEOTERM_SUBPKG_REPLACES="libllvm (<< 16.0.0)"
