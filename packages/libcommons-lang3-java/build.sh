TERMUX_PKG_HOMEPAGE=https://commons.apache.org/proper/commons-lang/
TERMUX_PKG_DESCRIPTION="A host of helper utilities for the java.lang API"
TERMUX_PKG_LICENSE="Apache-2.0"
TERMUX_PKG_MAINTAINER="@neoterm"
TERMUX_PKG_VERSION="3.14.0"
TERMUX_PKG_SRCURL=https://dlcdn.apache.org/commons/lang/source/commons-lang3-${TERMUX_PKG_VERSION}-src.tar.gz
TERMUX_PKG_SHA256=bc007577652f7cda7d5dc8801f218f88396ea1981cb4482679e839f5781e3b60
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="openjdk-17"
TERMUX_PKG_PLATFORM_INDEPENDENT=true
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_make() {
	cd src/main/java
	javac -encoding UTF-8 -source 1.8 -target 1.8 $(find . -name "*.java")
	_BUILD_JARFILE="$TERMUX_PKG_BUILDDIR/commons-lang3.jar"
	rm -f "$_BUILD_JARFILE"
	jar cf "$_BUILD_JARFILE" $(find . -name "*.class")
}

termux_step_make_install() {
	mkdir -p $TERMUX_PREFIX/share/java
	install -Dm600 "$_BUILD_JARFILE" $TERMUX_PREFIX/share/java/
}
