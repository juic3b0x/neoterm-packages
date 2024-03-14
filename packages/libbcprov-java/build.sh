NEOTERM_PKG_HOMEPAGE=https://www.bouncycastle.org/java.html
NEOTERM_PKG_DESCRIPTION="A lightweight cryptography API for Java"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_LICENSE_FILE="LICENSE.html"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.77"
NEOTERM_PKG_SRCURL=https://github.com/bcgit/bc-java/archive/refs/tags/r${NEOTERM_PKG_VERSION/./rv}.tar.gz
NEOTERM_PKG_SHA256=09659ee93ba2143d0db9107ddf515142f1d90e03d82d3e46a16e21e9eafeba84
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_UPDATE_VERSION_SED_REGEXP='s/rv/./;s/r//'
NEOTERM_PKG_DEPENDS="openjdk-17"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	cd prov
	local src_dirs="src/main/java ../core/src/main/java"
	javac -encoding UTF-8 -source 1.8 -target 1.8 $(find $src_dirs -name "*.java")
	_BUILD_JARFILE="$NEOTERM_PKG_BUILDDIR/bcprov.jar"
	rm -f "$_BUILD_JARFILE"
	for d in $src_dirs; do
		local jar_op=u
		if [ ! -e "$_BUILD_JARFILE" ]; then
			jar_op=c
		fi
		pushd $d
		jar ${jar_op}f "$_BUILD_JARFILE" $(find . -name "*.class")
		popd
	done
}

neoterm_step_make_install() {
	mkdir -p $NEOTERM_PREFIX/share/java
	install -Dm600 "$_BUILD_JARFILE" $NEOTERM_PREFIX/share/java/
}
