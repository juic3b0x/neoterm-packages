NEOTERM_PKG_HOMEPAGE=https://github.com/swh/LRDF
NEOTERM_PKG_DESCRIPTION="A library to make it easy to manipulate RDF files describing LADSPA plugins"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.6.1
NEOTERM_PKG_SRCURL=https://github.com/swh/LRDF/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=d579417c477ac3635844cd1b94f273ee2529a8c3b6b21f9b09d15f462b89b1ef
NEOTERM_PKG_DEPENDS="libraptor2"

neoterm_step_pre_configure() {
	autoreconf -fi
}
