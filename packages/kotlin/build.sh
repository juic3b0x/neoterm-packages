NEOTERM_PKG_HOMEPAGE=https://kotlinlang.org/
NEOTERM_PKG_DESCRIPTION="The Kotlin Programming Language"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.9.23"
NEOTERM_PKG_SRCURL=https://github.com/JetBrains/kotlin/releases/download/v${NEOTERM_PKG_VERSION}/kotlin-compiler-${NEOTERM_PKG_VERSION}.zip
NEOTERM_PKG_SHA256=93137d3aab9afa9b27cb06a824c2324195c6b6f6179d8a8653f440f5bd58be88
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="openjdk-17"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_make_install() {
	rm -f ./bin/*.bat
	rm -rf $NEOTERM_PREFIX/opt/kotlin
	mkdir -p $NEOTERM_PREFIX/opt/kotlin
	cp -r ./* $NEOTERM_PREFIX/opt/kotlin/
	for i in $NEOTERM_PREFIX/opt/kotlin/bin/*; do
		if [ ! -f "$i" ]; then
			continue
		fi
		ln -sfr $i $NEOTERM_PREFIX/bin/$(basename $i)
	done
}
