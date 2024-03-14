NEOTERM_PKG_HOMEPAGE=https://www.soimort.org/translate-shell
NEOTERM_PKG_DESCRIPTION="Command-line translator using Google Translate, Bing Translator, Yandex.Translate, etc."
NEOTERM_PKG_LICENSE="Public Domain"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.9.7.1"
NEOTERM_PKG_SRCURL=https://github.com/soimort/translate-shell/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=f949f379779b9e746bccb20fcd180d041fb90da95816615575b49886032bcefa
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="bash, curl, gawk, less, rlwrap"
# hunspell - spell checking
# mpv - text-to-speech functionality
NEOTERM_PKG_RECOMMENDS="hunspell, mpv"
NEOTERM_PKG_EXTRA_MAKE_ARGS="PREFIX=$NEOTERM_PREFIX"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
