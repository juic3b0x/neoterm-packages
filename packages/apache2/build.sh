NEOTERM_PKG_HOMEPAGE=https://httpd.apache.org
NEOTERM_PKG_DESCRIPTION="Apache Web Server"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1:2.4.58
NEOTERM_PKG_SRCURL=https://www.apache.org/dist/httpd/httpd-${NEOTERM_PKG_VERSION:2}.tar.bz2
NEOTERM_PKG_SHA256=fa16d72a078210a54c47dd5bef2f8b9b8a01d94909a51453956b3ec6442ea4c5
NEOTERM_PKG_DEPENDS="apr, apr-util, libandroid-support, libcrypt, libnghttp2, libuuid, openssl, pcre2, zlib"
NEOTERM_PKG_BREAKS="apache2-dev"
NEOTERM_PKG_REPLACES="apache2-dev"
NEOTERM_PKG_CONFFILES="
etc/apache2/httpd.conf
etc/apache2/extra/httpd-autoindex.conf
etc/apache2/extra/httpd-dav.conf
etc/apache2/extra/httpd-default.conf
etc/apache2/extra/httpd-info.conf
etc/apache2/extra/httpd-languages.conf
etc/apache2/extra/httpd-manual.conf
etc/apache2/extra/httpd-mpm.conf
etc/apache2/extra/httpd-multilang-errordoc.conf
etc/apache2/extra/httpd-ssl.conf
etc/apache2/extra/httpd-userdir.conf
etc/apache2/extra/httpd-vhosts.conf
etc/apache2/extra/proxy-html.conf
etc/apache2/mime.types
etc/apache2/magic
"

NEOTERM_PKG_AUTO_UPDATE=true

# providing manual paths to libs because it picks up host libs on some systems
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--with-apr=$NEOTERM_PREFIX
--with-apr-util=$NEOTERM_PREFIX
--with-pcre=$NEOTERM_PREFIX
--enable-suexec
--enable-layout=Termux
--enable-so
--enable-authnz-fcgi
--enable-cache
--enable-disk-cache
--enable-mem-cache
--enable-file-cache
--enable-ssl
--with-ssl
--enable-deflate
--enable-cgi
--enable-cgid
--enable-proxy
--enable-proxy-connect
--enable-proxy-http
--enable-proxy-ftp
--enable-dbd
--enable-imagemap
--enable-ident
--enable-cern-meta
--enable-http2
--enable-mpms-shared=all
--enable-modules=all
--enable-mods-shared=all
--disable-brotli
--disable-lua
--disable-mods-static
--disable-md
--with-port=8080
--with-sslport=8443
--enable-unixd
--without-libxml2
--libexecdir=$NEOTERM_PREFIX/libexec/apache2
ac_cv_func_getpwnam=yes
ac_cv_have_threadsafe_pollset=no
ac_cv_prog_PCRE_CONFIG=pcre2-config
"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_RM_AFTER_INSTALL="share/apache2/manual etc/apache2/original share/man/man8/suexec.8 libexec/httpd.exp"
NEOTERM_PKG_EXTRA_MAKE_ARGS="-s"
NEOTERM_PKG_SERVICE_SCRIPT=("httpd" 'exec httpd -DNO_DETACH 2>&1')
NEOTERM_PKG_HOSTBUILD=true

neoterm_step_host_build() {
	gcc -O2 -DCROSS_COMPILE $NEOTERM_PKG_SRCDIR/server/gen_test_char.c \
		-o gen_test_char
}

neoterm_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $NEOTERM_PREFIX.
	if $NEOTERM_ON_DEVICE_BUILD; then
		neoterm_error_exit "Package '$NEOTERM_PKG_NAME' is not safe for on-device builds."
	fi

	# remove old files
	rm -rf "$NEOTERM_PREFIX"/{libexec,share,etc}/apache2
	rm -rf "$NEOTERM_PREFIX"/lib/cgi-bin

	if [ $NEOTERM_ARCH_BITS -eq 32 ]; then
		export ap_cv_void_ptr_lt_long=4
	else
		export ap_cv_void_ptr_lt_long=8
	fi

	LDFLAGS="$LDFLAGS -lapr-1 -laprutil-1"

	# use custom layout
	cat $NEOTERM_PKG_BUILDER_DIR/Termux.layout > $NEOTERM_PKG_SRCDIR/config.layout

	make -C $NEOTERM_PKG_SRCDIR/libdummy
	ldflags_tmp="-L$NEOTERM_PKG_SRCDIR/libdummy -Wl,--as-needed"
	for m in cache dav proxy session watchdog; do
		ldflags_tmp+=,-ldummy-mod_$m
	done
	libexecdir=$NEOTERM_PREFIX/libexec/apache2
	LDFLAGS+=" $ldflags_tmp -Wl,-rpath=$libexecdir"
}

neoterm_step_post_configure() {
	install -m700 $NEOTERM_PKG_HOSTBUILD_DIR/gen_test_char \
		$NEOTERM_PKG_BUILDDIR/server/gen_test_char
	touch -d "1 hour" $NEOTERM_PKG_BUILDDIR/server/gen_test_char
}

neoterm_step_post_make_install() {
	sed -e "s#/$NEOTERM_PREFIX/libexec/apache2/#modules/#" \
		-e 's|#\(LoadModule negotiation_module \)|\1|' \
		-e 's|#\(LoadModule include_module \)|\1|' \
		-e 's|#\(LoadModule userdir_module \)|\1|' \
		-e 's|#\(LoadModule slotmem_shm_module \)|\1|' \
		-e 's|#\(Include extra/httpd-multilang-errordoc.conf\)|\1|' \
		-e 's|#\(Include extra/httpd-autoindex.conf\)|\1|' \
		-e 's|#\(Include extra/httpd-languages.conf\)|\1|' \
		-e 's|#\(Include extra/httpd-userdir.conf\)|\1|' \
		-e 's|#\(Include extra/httpd-default.conf\)|\1|' \
		-e 's|#\(Include extra/httpd-mpm.conf\)|\1|' \
		-e 's|User daemon|#User daemon|' \
		-e 's|Group daemon|#Group daemon|' \
		-i "$NEOTERM_PREFIX/etc/apache2/httpd.conf"
	echo -e "#\n#  Load config files from the config directory 'conf.d'.\n#\nInclude etc/apache2/conf.d/*.conf" >> $NEOTERM_PREFIX/etc/apache2/httpd.conf
}

neoterm_step_post_massage() {
	# sometimes it creates a $NEOTERM_PREFIX/bin/sh -> /bin/sh
	rm -f ${NEOTERM_PKG_MASSAGEDIR}${NEOTERM_PREFIX}/bin/sh

	mkdir -p ${NEOTERM_PKG_MASSAGEDIR}${NEOTERM_PREFIX}/etc/apache2/conf.d
	touch ${NEOTERM_PKG_MASSAGEDIR}${NEOTERM_PREFIX}/etc/apache2/conf.d/placeholder.conf
	mkdir -p ${NEOTERM_PKG_MASSAGEDIR}${NEOTERM_PREFIX}/var/run/apache2
	mkdir -p ${NEOTERM_PKG_MASSAGEDIR}${NEOTERM_PREFIX}/var/log/apache2
}
