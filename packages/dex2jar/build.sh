NEOTERM_PKG_HOMEPAGE=https://github.com/pxb1988/dex2jar
NEOTERM_PKG_DESCRIPTION="Tools to work with android .dex and java .class files"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.4"
NEOTERM_PKG_SRCURL=https://github.com/pxb1988/dex2jar/releases/download/v${NEOTERM_PKG_VERSION}/dex-tools-v${NEOTERM_PKG_VERSION}.zip
NEOTERM_PKG_SHA256=ee7c45eb3c1d2474a6145d8d447e651a736a22d9664b6d3d3be5a5a817dda23a
NEOTERM_PKG_DEPENDS="openjdk-17"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_make_install() {
	rm -rf ./bin/*.bat
	rm -rf ./*.bat
	mkdir -p $NEOTERM_PREFIX/opt/dex2jar
	cp -r ./* $NEOTERM_PREFIX/opt/dex2jar
	ln -sfr $NEOTERM_PREFIX/opt/dex2jar/bin/dex-tools $NEOTERM_PREFIX/bin/d2j-run
	cd $NEOTERM_PREFIX/opt/dex2jar/
	for i in *.sh; do
		ln -sfr $NEOTERM_PREFIX/opt/dex2jar/$i $NEOTERM_PREFIX/bin/${i%%.sh}
	done
}
