NEOTERM_SUBPKG_INCLUDE="
bin/bugpoint
bin/dsymutil
bin/llc
bin/lli
bin/llvm!(-jitlink-executor|-PerfectShuffle)
bin/opt
bin/sancov
bin/sanstats
bin/split-file
bin/verify-uselistorder
share/man/man1/bugpoint.1.gz
share/man/man1/dsymutil.1.gz
share/man/man1/llc.1.gz
share/man/man1/lli.1.gz
share/man/man1/llvm*
share/man/man1/opt.1.gz
share/man/man1/*tblgen.1.gz
share/opt-viewer
"
NEOTERM_SUBPKG_DESCRIPTION="LLVM modular compiler and toolchain executables"
NEOTERM_SUBPKG_BREAKS="libllvm (<< 11.0.0-1)"
NEOTERM_SUBPKG_REPLACES="libllvm (<< 11.0.0-1)"
