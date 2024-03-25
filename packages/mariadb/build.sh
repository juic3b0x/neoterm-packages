NEOTERM_PKG_HOMEPAGE=https://mariadb.org
NEOTERM_PKG_DESCRIPTION="A drop-in replacement for mysql server"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2:11.3.2"
NEOTERM_PKG_SRCURL=https://mirror.netcologne.de/mariadb/mariadb-${NEOTERM_PKG_VERSION#*:}/source/mariadb-${NEOTERM_PKG_VERSION#*:}.tar.gz
NEOTERM_PKG_SHA256=5570778f0a2c27af726c751cda1a943f3f8de96d11d107791be5b44a0ce3fb5c
NEOTERM_PKG_DEPENDS="libandroid-support, libc++, libcrypt, libedit, liblz4, liblzma, ncurses, openssl, pcre2, zlib"
NEOTERM_PKG_BREAKS="mariadb-dev"
NEOTERM_PKG_CONFLICTS="mysql"
NEOTERM_PKG_REPLACES="mariadb-dev"
NEOTERM_PKG_SERVICE_SCRIPT=("mysqld" "exec mysqld --basedir=$NEOTERM_PREFIX --datadir=$NEOTERM_PREFIX/var/lib/mysql 2>&1")
NEOTERM_PKG_HOSTBUILD=true
NEOTERM_CMAKE_BUILD="Unix Makefiles"
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DBISON_EXECUTABLE=$(command -v bison)
-DGETCONF=$(command -v getconf)
-DBUILD_CONFIG=mysql_release
-DCAT_EXECUTABLE=$(command -v cat)
-DGIT_EXECUTABLE=$(command -v git)
-DGSSAPI_FOUND=NO
-DGRN_WITH_LZ4=yes
-DENABLED_LOCAL_INFILE=ON
-DHAVE_UCONTEXT_H=False
-DIMPORT_EXECUTABLES=$NEOTERM_PKG_HOSTBUILD_DIR/import_executables.cmake
-DINSTALL_LAYOUT=DEB
-DINSTALL_UNIX_ADDRDIR=$NEOTERM_PREFIX/var/run/mysqld.sock
-DINSTALL_SBINDIR=$NEOTERM_PREFIX/bin
-DMYSQL_DATADIR=$NEOTERM_PREFIX/var/lib/mysql
-DPLUGIN_AUTH_GSSAPI_CLIENT=OFF
-DPLUGIN_AUTH_GSSAPI=NO
-DPLUGIN_AUTH_PAM=NO
-DPLUGIN_CONNECT=NO
-DPLUGIN_DAEMON_EXAMPLE=NO
-DPLUGIN_EXAMPLE=NO
-DPLUGIN_GSSAPI=OFF
-DPLUGIN_ROCKSDB=NO
-DPLUGIN_TOKUDB=NO
-DPLUGIN_SERVER_AUDIT=NO
-DSTACK_DIRECTION=-1
-DTMPDIR=$NEOTERM_PREFIX/tmp
-DWITH_EXTRA_CHARSETS=complex
-DWITH_JEMALLOC=OFF
-DWITH_MARIABACKUP=OFF
-DWITH_PCRE=system
-DWITH_LZ4=system
-DWITH_READLINE=OFF
-DWITH_SSL=system
-DWITH_WSREP=False
-DWITH_ZLIB=system
-DWITH_INNODB_BZIP2=OFF
-DWITH_INNODB_LZ4=ON
-DWITH_INNODB_LZMA=ON
-DWITH_INNODB_LZO=OFF
-DWITH_INNODB_SNAPPY=OFF
-DWITH_UNIT_TESTS=OFF
-DSTAT_EMPTY_STRING_BUG_EXITCODE=0
-DLSTAT_FOLLOWS_SLASHED_SYMLINK_EXITCODE=0
-DMASK_LONGDOUBLE_EXITCODE=1
-DINSTALL_SYSCONFDIR=$NEOTERM_PREFIX/etc
"
NEOTERM_PKG_RM_AFTER_INSTALL="
bin/mysqltest*
share/man/man1/mysql-test-run.pl.1
share/mysql/mysql-test
mysql-test
sql-bench
"

neoterm_step_host_build() {
	neoterm_setup_cmake
	sed -i 's/^\s*END[(][)]/ENDIF()/g' $NEOTERM_PKG_SRCDIR/libmariadb/cmake/ConnectorName.cmake
	cmake -G "Unix Makefiles" \
		$NEOTERM_PKG_SRCDIR \
		-DWITH_SSL=bundled \
		-DCMAKE_BUILD_TYPE=Release
	make -j $NEOTERM_MAKE_PROCESSES import_executables
}

neoterm_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $NEOTERM_PREFIX.
	if $NEOTERM_ON_DEVICE_BUILD; then
		neoterm_error_exit "Package '$NEOTERM_PKG_NAME' is not safe for on-device builds."
	fi

	CPPFLAGS+=" -Dushort=u_short"

	if [ $NEOTERM_ARCH_BITS = 32 ]; then
		CPPFLAGS+=" -D__off64_t_defined"
	fi

	sed -i 's/^\s*END[(][)]/ENDIF()/g' $NEOTERM_PKG_SRCDIR/libmariadb/cmake/ConnectorName.cmake

	export PATH=$NEOTERM_PKG_HOSTBUILD_DIR/strings:$PATH
}

neoterm_step_post_massage() {
	mkdir -p $NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/etc/my.cnf.d
}

neoterm_step_create_debscripts() {
	echo "if [ ! -e "$NEOTERM_PREFIX/var/lib/mysql" ]; then" > postinst
	echo "  echo 'Initializing mysql data directory...'" >> postinst
	echo "  mkdir -p $NEOTERM_PREFIX/var/lib/mysql" >> postinst
	echo "  $NEOTERM_PREFIX/bin/mysql_install_db --user=root --auth-root-authentication-method=normal --datadir=$NEOTERM_PREFIX/var/lib/mysql --basedir=$NEOTERM_PREFIX" >> postinst
	echo "fi" >> postinst
	echo "exit 0" >> postinst
	chmod 0755 postinst
}
