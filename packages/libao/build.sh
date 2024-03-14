NEOTERM_PKG_HOMEPAGE=https://www.xiph.org/ao/
NEOTERM_PKG_DESCRIPTION="A cross platform audio library"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.2.2
NEOTERM_PKG_REVISION=7
NEOTERM_PKG_SRCURL=https://github.com/xiph/libao/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=df8a6d0e238feeccb26a783e778716fb41a801536fe7b6fce068e313c0e2bf4d
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_DEPENDS="pulseaudio"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--enable-pulse"
NEOTERM_PKG_CONFFILES="etc/libao.conf"

neoterm_step_pre_configure () {
	./autogen.sh
}

neoterm_step_post_make_install () {
	#generate libao config file
	mkdir -p $NEOTERM_PREFIX/etc/
	cat << EOF > $NEOTERM_PREFIX/etc/libao.conf
default_driver=pulse
buffer_time=50
quiet
EOF
}
