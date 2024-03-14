NEOTERM_PKG_HOMEPAGE=https://www.postgresql.org
NEOTERM_PKG_DESCRIPTION="Object-relational SQL database"
NEOTERM_PKG_LICENSE="PostgreSQL"
NEOTERM_PKG_LICENSE_FILE="COPYRIGHT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="16.1"
NEOTERM_PKG_SRCURL=https://ftp.postgresql.org/pub/source/v$NEOTERM_PKG_VERSION/postgresql-$NEOTERM_PKG_VERSION.tar.bz2
NEOTERM_PKG_SHA256=ce3c4d85d19b0121fe0d3f8ef1fa601f71989e86f8a66f7dc3ad546dd5564fec
NEOTERM_PKG_DEPENDS="libandroid-execinfo, libandroid-shmem, libicu, libuuid, libxml2, openssl, readline, zlib"
# - pgac_cv_prog_cc_LDFLAGS_EX_BE__Wl___export_dynamic: Needed to fix PostgreSQL 16 that
#   causes initdb failure: cannot locate symbol
# - pgac_cv_prog_cc_LDFLAGS__Wl___as_needed: Inform that the linker supports as-needed. It's
#   not stricly necessary but avoids unnecessary linking of binaries.
# - USE_UNNAMED_POSIX_SEMAPHORES: Avoid using System V semaphores which are disabled on Android.
# - ZIC=...: The zic tool is used to build the time zone database bundled with postgresql.
#   We specify a binary built in neoterm_step_host_build which has been patched to use symlinks
#   over hard links (which are not supported as of Android 6.0+).
#   There exists a --with-system-tzdata configure flag, but that does not work here as Android
#   uses a custom combined tzdata file.
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--with-icu
--with-libxml
--with-openssl
--with-uuid=e2fs
USE_UNNAMED_POSIX_SEMAPHORES=1
ZIC=${NEOTERM_PKG_HOSTBUILD_DIR}/src/timezone/zic
pgac_cv_prog_cc_LDFLAGS_EX_BE__Wl___export_dynamic=yes
pgac_cv_prog_cc_LDFLAGS__Wl___as_needed=yes
"
NEOTERM_PKG_RM_AFTER_INSTALL="
bin/ecpg
lib/libecpg*
share/man/man1/ecpg.1
"
NEOTERM_PKG_HOSTBUILD=true
NEOTERM_PKG_BREAKS="postgresql-contrib (<= 10.3-1), postgresql-dev"
NEOTERM_PKG_REPLACES="postgresql-contrib (<= 10.3-1), postgresql-dev"
NEOTERM_PKG_SERVICE_SCRIPT=("postgres" "mkdir -p ~/.postgres\nif [ -f \"~/.postgres/postgresql.conf\" ]; then DATADIR=\"~/.postgres\"; else DATADIR=\"$NEOTERM_PREFIX/var/lib/postgresql\"; fi\nexec postgres -D \$DATADIR 2>&1")

neoterm_step_host_build() {
	# Build a native zic binary which we have patched to
	# use symlinks instead of hard links.
	$NEOTERM_PKG_SRCDIR/configure --without-readline
	make -j "${NEOTERM_MAKE_PROCESSES}"
}

neoterm_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $NEOTERM_PREFIX.
	if $NEOTERM_ON_DEVICE_BUILD; then
		neoterm_error_exit "Package '$NEOTERM_PKG_NAME' is not safe for on-device builds."
	fi
}

neoterm_step_post_make_install() {
	# Man pages are not installed by default:
	make -C doc/src/sgml install-man

	for contrib in \
		btree_gist \
		citext \
		dblink \
		fuzzystrmatch \
		hstore \
		pageinspect \
		pg_freespacemap \
		pg_stat_statements \
		pg_trgm \
		pgcrypto \
		pgrowlocks \
		postgres_fdw \
		tablefunc \
		unaccent \
		uuid-ossp \
		; do
		(make -C contrib/${contrib} -s -j ${NEOTERM_MAKE_PROCESSES} install)
	done
}
