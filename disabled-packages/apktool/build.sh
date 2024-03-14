NEOTERM_PKG_HOMEPAGE=https://ibotpeaches.github.io/Apktool/
NEOTERM_PKG_DESCRIPTION="A tool for reverse engineering 3rd party, closed, binary Android apps"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.6.1
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/iBotPeaches/Apktool/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=8932e77d963b9e0e07227422d82ed4a355e8aa268bad1361e5cfaffa8e4d52ee
NEOTERM_PKG_DEPENDS="aapt, aapt2, openjdk-17"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	local prebuilt_dir="brut.apktool/apktool-lib/src/main/resources/prebuilt"
	rm -rf $prebuilt_dir/{linux,macosx,windows}
	mkdir -p $prebuilt_dir/linux
	for exe_name in aapt aapt2; do
		local exe_path=$prebuilt_dir/linux/${exe_name}
		$CC $CFLAGS $CPPFLAGS aapt-wrapper/${exe_name}-wrapper.c \
			-o ${exe_path} $LDFLAGS
		cp -a ${exe_path} ${exe_path}_64
	done
}

neoterm_step_make() {
	sh gradlew build shadowJar -x test
}

neoterm_step_make_install() {
	install -Dm600 brut.apktool/apktool-cli/build/libs/apktool-cli-all.jar \
		$NEOTERM_PREFIX/share/java/apktool.jar
	cat <<- EOF > $NEOTERM_PREFIX/bin/apktool
	#!${NEOTERM_PREFIX}/bin/sh
	exec java -jar $NEOTERM_PREFIX/share/java/apktool.jar "\$@"
	EOF
	chmod 700 $NEOTERM_PREFIX/bin/apktool
}
