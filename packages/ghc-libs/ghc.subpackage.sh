# shellcheck shell=bash
NEOTERM_SUBPKG_DESCRIPTION="The Glasgow Haskell Compiler"
NEOTERM_SUBPKG_DEPENDS="binutils-is-llvm | binutils, llvm, clang"

NEOTERM_SUBPKG_INCLUDE="lib/ghc-$NEOTERM_PKG_VERSION/ghc-$NEOTERM_PKG_VERSION"

while read -r file; do
	NEOTERM_SUBPKG_INCLUDE+=" ${file/$NEOTERM_PREFIX\//}"
done < <(find "$NEOTERM_PREFIX"/lib/ghc-"$NEOTERM_PKG_VERSION"/bin -type f -or -type l -not -name "ghc-pkg*" -print)

while read -r file; do
	NEOTERM_SUBPKG_INCLUDE+=" ${file/$NEOTERM_PREFIX\//}"
done < <(find "$NEOTERM_PREFIX"/bin -type f -or -type l -not -name "ghc-pkg*" -print)
