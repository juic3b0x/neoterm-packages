NEOTERM_PKG_HOMEPAGE=https://github.com/mstrobel/procyon
NEOTERM_PKG_DESCRIPTION="A standalone front-end for the Java decompiler in Procyon Compiler Toolset"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.6.0
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/mstrobel/procyon/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=516f410868f7523d804362a9dff5fa8fcf9232e5ee36bb7f0a5c8f71d5de7fe4
NEOTERM_PKG_DEPENDS="openjdk-17"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	./gradlew build -x test -x javadoc
}

neoterm_step_make_install() {
	install -Dm600 -T \
		./build/Procyon.Decompiler/libs/procyon-decompiler-${NEOTERM_PKG_VERSION}.jar \
		$NEOTERM_PREFIX/share/java/procyon-decompiler.jar
	install -Dm700 -t $NEOTERM_PREFIX/bin procyon-decompiler
}
