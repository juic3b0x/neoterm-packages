NEOTERM_PKG_HOMEPAGE=https://z-push.org/
NEOTERM_PKG_DESCRIPTION="An open-source application to synchronize ActiveSync compatible devices and Outlook"
NEOTERM_PKG_LICENSE="AGPL-V3"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.7.1"
NEOTERM_PKG_SRCURL=https://github.com/Z-Hub/Z-Push/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=7aadddb5da06494a35c79e4b70d6ade6b2f62203f3df343077731f8952b64a41
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="apache2, php"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make_install() {
	cp -rT src $NEOTERM_PREFIX/share/z-push
	local f
	for f in z-push-{admin,top}; do
		ln -sfr $NEOTERM_PREFIX/share/z-push/${f}.php $NEOTERM_PREFIX/bin/${f}
		install -Dm600 -t $NEOTERM_PREFIX/share/man/man8 man/${f}.8
	done
	install -Dm600 -t $NEOTERM_PREFIX/etc/apache2/conf.d config/apache2/*.conf
}

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	mkdir -p $NEOTERM_PREFIX/var/lib/z-push
	mkdir -p $NEOTERM_PREFIX/var/log/z-push
	EOF
}

