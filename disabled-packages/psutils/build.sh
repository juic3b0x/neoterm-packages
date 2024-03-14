NEOTERM_PKG_HOMEPAGE=https://github.com/rrthomas/psutils
NEOTERM_PKG_DESCRIPTION="A set of postscript utilities"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.10"
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL="https://github.com/rrthomas/psutils/releases/download/v${NEOTERM_PKG_VERSION}/psutils-${NEOTERM_PKG_VERSION}.tar.gz"
NEOTERM_PKG_SHA256=6f8339fd5322df5c782bfb355d9f89e513353220fca0700a5a28775404d7e98b
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="ghostscript, perl, libpaper"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_path_PAPER=${NEOTERM_PREFIX}/bin/paper"

neoterm_step_post_massage() {
	local perl_version
	perl_version=$(
		. "${NEOTERM_SCRIPTDIR}"/packages/perl/build.sh
		echo "${NEOTERM_PKG_VERSION[0]}"
	)

	# Make sure that perl can find PSUtils module.
	mkdir -p "${NEOTERM_PKG_MASSAGEDIR}/${NEOTERM_PREFIX}/lib/perl5/${perl_version}"
	mv -f "${NEOTERM_PKG_MASSAGEDIR}/${NEOTERM_PREFIX}"/share/psutils/PSUtils.pm \
		"${NEOTERM_PKG_MASSAGEDIR}/${NEOTERM_PREFIX}/lib/perl5/${perl_version}"/
	rmdir "${NEOTERM_PKG_MASSAGEDIR}/${NEOTERM_PREFIX}"/share/psutils
}
