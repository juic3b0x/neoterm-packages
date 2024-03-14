NEOTERM_PKG_HOMEPAGE=https://github.com/scop/bash-completion
NEOTERM_PKG_DESCRIPTION="Programmable completion for the bash shell"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="Joshua Kahn @TomJo2000"
NEOTERM_PKG_VERSION=2.12.0
NEOTERM_PKG_SRCURL=https://github.com/scop/bash-completion/releases/download/${NEOTERM_PKG_VERSION}/bash-completion-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=3eb05b1783c339ef59ed576afb0f678fa4ef49a6de8a696397df3148f8345af9
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="bash"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_RM_AFTER_INSTALL="
share/bash-completion/completions/makepkg
"
