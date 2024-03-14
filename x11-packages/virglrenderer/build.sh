NEOTERM_PKG_HOMEPAGE=https://virgil3d.github.io/
NEOTERM_PKG_DESCRIPTION="A virtual 3D GPU for use inside qemu virtual machines"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.0.1"
NEOTERM_PKG_SRCURL=https://gitlab.freedesktop.org/virgl/virglrenderer/-/archive/virglrenderer-${NEOTERM_PKG_VERSION}/virglrenderer-virglrenderer-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=446ab3e265f574ec598e77bdfbf0616ee3c77361f0574bec733ba4bac4df730a
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libdrm, libepoxy, libglvnd, libx11, mesa"
NEOTERM_PKG_BUILD_DEPENDS="xorgproto"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="-Dplatforms=egl,glx"

neoterm_step_pre_configure() {
    # error: using an array subscript expression within 'offsetof' is a Clang extension [-Werror,-Wgnu-offsetof-extensions]
    # list_for_each_entry_safe(struct vrend_linked_shader_program, ent, &shader->programs, sl[shader->sel->type])
    CPPFLAGS+=" -Wno-error=gnu-offsetof-extensions"
}
