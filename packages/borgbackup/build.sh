NEOTERM_PKG_HOMEPAGE=https://www.borgbackup.org/
NEOTERM_PKG_DESCRIPTION="Deduplicating and compressing backup program"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.2.7"
NEOTERM_PKG_SRCURL=https://github.com/borgbackup/borg/releases/download/${NEOTERM_PKG_VERSION}/borgbackup-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=f63f28a3383c041971cec87b061ca39a815b5fd445db24aa8172cac417d9411a
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libacl, liblz4, openssl, python, xxhash, zstd"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PYTHON_COMMON_DEPS="Cython, wheel"
NEOTERM_PKG_PYTHON_TARGET_DEPS="msgpack==1.0.5"

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	echo "Installing dependencies through pip..."
	pip3 install $NEOTERM_PKG_PYTHON_TARGET_DEPS
	EOF
}
