NEOTERM_PKG_HOMEPAGE=https://commons.apache.org/proper/commons-lang/
NEOTERM_PKG_DESCRIPTION="A host of helper utilities for the java.lang API"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.14.0"
NEOTERM_PKG_SRCURL=https://dlcdn.apache.org/commons/lang/source/commons-lang3-${NEOTERM_PKG_VERSION}-src.tar.gz
NEOTERM_PKG_SHA256=bc007577652f7cda7d5dc8801f218f88396ea1981cb4482679e839f5781e3b60
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="openjdk-17"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	cd src/main/java
	javac -encoding UTF-8 -source 1.8 -target 1.8 $(find . -name "*.java")
	_BUILD_JARFILE="$NEOTERM_PKG_BUILDDIR/commons-lang3.jar"
	rm -f "$_BUILD_JARFILE"
	jar cf "$_BUILD_JARFILE" $(find . -name "*.class")
}

neoterm_step_make_install() {
	mkdir -p $NEOTERM_PREFIX/share/java
	install -Dm600 "$_BUILD_JARFILE" $NEOTERM_PREFIX/share/java/
}
