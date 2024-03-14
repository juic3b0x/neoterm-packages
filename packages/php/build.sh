NEOTERM_PKG_HOMEPAGE=https://php.net
NEOTERM_PKG_DESCRIPTION="Server-side, HTML-embedded scripting language"
NEOTERM_PKG_LICENSE="PHP-3.01"
NEOTERM_PKG_LICENSE_FILE=LICENSE
NEOTERM_PKG_MAINTAINER="@neoterm"
# Please revbump php-* extensions along with "minor" bump (e.g. 8.1.x to 8.2.0)
NEOTERM_PKG_VERSION=8.2.8
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://github.com/php/php-src/archive/php-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=ec2a218e95901f7fbf5650bc6c0179bf993b25e9c53271d4df372f0d72c5274d
NEOTERM_PKG_AUTO_UPDATE=false
# Build native php for phar to build (see pear-Makefile.frag.patch):
NEOTERM_PKG_HOSTBUILD=true
# Build the native php without xml support as we only need phar:
NEOTERM_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS="--disable-libxml --disable-dom --disable-simplexml --disable-xml --disable-xmlreader --disable-xmlwriter --without-pear --disable-sqlite3 --without-libxml --without-sqlite3 --without-pdo-sqlite"
NEOTERM_PKG_DEPENDS="libandroid-glob, libandroid-support, libbz2, libc++, libcurl, libffi, libgd, libgmp, libiconv, libicu, libresolv-wrapper, libsqlite, libxml2, libxslt, libzip, oniguruma, openssl, pcre2, readline, tidy, zlib"
NEOTERM_PKG_CONFLICTS="php-mysql, php-dev"
NEOTERM_PKG_REPLACES="php-mysql, php-dev"
NEOTERM_PKG_RM_AFTER_INSTALL="php/php/fpm"
NEOTERM_PKG_SERVICE_SCRIPT=("php-fpm" "mkdir -p $NEOTERM_ANDROID_HOME/.php\nif [ -f \"$NEOTERM_ANDROID_HOME/.php/php-fpm.conf\" ]; then CONFIG=\"$NEOTERM_ANDROID_HOME/.php/php-fpm.conf\"; else CONFIG=\"$NEOTERM_PREFIX/etc/php-fpm.conf\"; fi\nexec php-fpm -F -y \$CONFIG -c ~/.php/php.ini 2>&1")

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_res_nsearch=no
ac_cv_phpdbg_userfaultfd_writefault=no
--enable-bcmath
--enable-calendar
--enable-exif
--enable-mbstring
--enable-opcache
--enable-pcntl
--enable-sockets
--mandir=$NEOTERM_PREFIX/share/man
--with-bz2=$NEOTERM_PREFIX
--with-curl=$NEOTERM_PREFIX
--with-ldap=shared,$NEOTERM_PREFIX
--with-ldap-sasl
--with-openssl=$NEOTERM_PREFIX
--with-readline=$NEOTERM_PREFIX
--with-sodium=shared,$NEOTERM_PREFIX
--with-iconv-dir=$NEOTERM_PREFIX
--with-zlib
--with-pgsql=shared,$NEOTERM_PREFIX
--with-pdo-pgsql=shared,$NEOTERM_PREFIX
--with-mysqli=mysqlnd
--with-pdo-mysql=mysqlnd
--with-mysql-sock=$NEOTERM_PREFIX/tmp/mysqld.sock
--with-apxs2=$NEOTERM_PKG_TMPDIR/apxs-wrapper.sh
--with-iconv=$NEOTERM_PREFIX
--enable-fpm
--enable-gd
--with-external-gd
--with-external-pcre
--with-zip
--with-xsl
--with-gmp
--with-ffi
--with-tidy=$NEOTERM_PREFIX
--enable-intl
--sbindir=$NEOTERM_PREFIX/bin
"

neoterm_step_host_build() {
	# PatchELF packaged in Ubuntu is too old.
	local PATCHELF_BUILD_SH=$NEOTERM_SCRIPTDIR/packages/patchelf/build.sh
	local PATCHELF_SRCURL=$(bash -c ". $PATCHELF_BUILD_SH; echo \$NEOTERM_PKG_SRCURL")
	local PATCHELF_SHA256=$(bash -c ". $PATCHELF_BUILD_SH; echo \$NEOTERM_PKG_SHA256")
	local PATCHELF_TARFILE=$NEOTERM_PKG_CACHEDIR/$(basename $PATCHELF_SRCURL)
	neoterm_download $PATCHELF_SRCURL $PATCHELF_TARFILE $PATCHELF_SHA256
	local PATCHELF_SRCDIR=$NEOTERM_PKG_HOSTBUILD_DIR/_patchelf
	mkdir -p $PATCHELF_SRCDIR
	tar xf $PATCHELF_TARFILE -C $PATCHELF_SRCDIR --strip-components=1
	pushd $PATCHELF_SRCDIR
	./bootstrap.sh
	./configure
	make -j $NEOTERM_MAKE_PROCESSES
	popd

	(cd "$NEOTERM_PKG_SRCDIR" && ./buildconf --force)
	"$NEOTERM_PKG_SRCDIR/configure" ${NEOTERM_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS}
	make -j "$NEOTERM_MAKE_PROCESSES"
}

neoterm_step_pre_configure() {
	export PATH=$NEOTERM_PKG_HOSTBUILD_DIR/_patchelf/src:$PATH

	LDFLAGS+=" -lresolv_wrapper -landroid-glob -llog $($CC -print-libgcc-file-name)"

	export PATH=$PATH:$NEOTERM_PKG_HOSTBUILD_DIR/sapi/cli/
	export NATIVE_PHP_EXECUTABLE=$NEOTERM_PKG_HOSTBUILD_DIR/sapi/cli/php
	export NATIVE_MINILUA_EXECUTABLE=$NEOTERM_PKG_HOSTBUILD_DIR/ext/opcache/minilua
	if [ "$NEOTERM_ARCH" = "aarch64" ]; then
		CFLAGS+=" -march=armv8-a+crc"
		CXXFLAGS+=" -march=armv8-a+crc"
	fi
	# Regenerate configure again since we have patched config.m4 files.
	./buildconf --force

	export EXTENSION_DIR=$NEOTERM_PREFIX/lib/php

	# Use a wrapper since bin/apxs has the Termux shebang:
	echo "perl $NEOTERM_PREFIX/bin/apxs \$@" > $NEOTERM_PKG_TMPDIR/apxs-wrapper.sh
	chmod +x $NEOTERM_PKG_TMPDIR/apxs-wrapper.sh
	cat $NEOTERM_PKG_TMPDIR/apxs-wrapper.sh

	# Fix overlinking (unneeded DT_NEEDED entries) with libtool:
	local wrapper_bin=$NEOTERM_PKG_BUILDDIR/_wrapper/bin
	local _cc=$(basename $CC)
	rm -rf $wrapper_bin
	mkdir -p $wrapper_bin
	cat <<-EOF > $wrapper_bin/$_cc
		#!$(command -v sh)
		exec $(command -v $_cc) \
			--start-no-unused-arguments \
			-Wl,--as-needed \
			--end-no-unused-arguments \
			"\$@"
	EOF
	chmod 0700 $wrapper_bin/$_cc
	export PATH=$wrapper_bin:$PATH
}

neoterm_step_post_configure() {
	# Avoid src/ext/gd/gd.c trying to include <X11/xpm.h>:
	sed -i 's/#define HAVE_GD_XPM 1//' $NEOTERM_PKG_BUILDDIR/main/php_config.h
	# Avoid src/ext/standard/dns.c trying to use struct __res_state:
	sed -i 's/#define HAVE_RES_NSEARCH 1//' $NEOTERM_PKG_BUILDDIR/main/php_config.h
}

neoterm_step_post_make_install() {
	mkdir -p $NEOTERM_PREFIX/etc/php-fpm.d
	cp sapi/fpm/php-fpm.conf $NEOTERM_PREFIX/etc/
	cp sapi/fpm/www.conf $NEOTERM_PREFIX/etc/php-fpm.d/

	docdir=$NEOTERM_PREFIX/share/doc/php
	mkdir -p $docdir
	for suffix in development production; do
		cp $NEOTERM_PKG_SRCDIR/php.ini-$suffix $docdir/
	done

	sed -i 's/SED=.*/SED=sed/' $NEOTERM_PREFIX/bin/phpize

	# Shared extensions for PHP/Apache
	mkdir -p $NEOTERM_PREFIX/lib/php-apache
	local f
	for f in opcache ldap pdo_pgsql pgsql sodium; do
		local so=$NEOTERM_PREFIX/lib/php-apache/${f}.so
		rm -f ${so}
		cp -T $NEOTERM_PREFIX/lib/php/${f}.so ${so}
		patchelf --set-rpath $NEOTERM_PREFIX/libexec/apache2:$NEOTERM_PREFIX/lib \
			--add-needed libphp.so \
			${so}
	done
}
