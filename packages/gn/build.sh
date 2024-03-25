NEOTERM_PKG_HOMEPAGE=https://gn.googlesource.com/gn
NEOTERM_PKG_DESCRIPTION="Meta-build system that generates build files for Ninja"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="Yaksh Bariya <thunder-coding@neoterm.dev>"
NEOTERM_PKG_SRCURL=git+https://gn.googlesource.com/gn
_COMMIT=53ef169800760fdc09f0773bf380fe99eaeab339
_COMMIT_DATE=2022.05.02
NEOTERM_PKG_VERSION=${_COMMIT_DATE//./}
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_GIT_BRANCH=main
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_RECOMMENDS="ninja"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT

	local version="$(git log -1 --format=%cs | sed 's/-/./g')"
	if [ "$version" != "$_COMMIT_DATE" ]; then
		echo -n "ERROR: The specified commit date \"$_COMMIT_DATE\""
		echo " is different from what is expected to be: \"$version\""
		return 1
	fi

}

neoterm_step_configure() {
	./build/gen.py --no-static-libstdc++
}

neoterm_step_make() {
	neoterm_setup_ninja
	ninja -C out/
}

neoterm_step_make_install() {
	install -Dm755 -t $NEOTERM_PREFIX/bin out/gn
}
