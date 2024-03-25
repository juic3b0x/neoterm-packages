NEOTERM_PKG_HOMEPAGE="https://github.com/pinard/Recode"
NEOTERM_PKG_DESCRIPTION="Charset converter tool and library"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="Marlin Sööse <marlin.soose@laro.se>"
NEOTERM_PKG_VERSION="3.7.14"
NEOTERM_PKG_SRCURL=https://github.com/rrthomas/recode/releases/download/v${NEOTERM_PKG_VERSION}/recode-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=786aafd544851a2b13b0a377eac1500f820ce62615ccc2e630b501e7743b9f33
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libiconv"
# recode needs to be explicitly linked to avoid:
# CANNOT LINK EXECUTABLE "recode": cannot locate symbol "libiconv_open"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="LIBS=-liconv"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+="
ac_cv_path_HELP2MAN=:
"
