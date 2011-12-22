# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/glfw/glfw-2.6.ebuild,v 1.6 2010/09/13 12:09:46 tupone Exp $

EAPI=2
inherit eutils multilib

DESCRIPTION="The Portable OpenGL FrameWork"
HOMEPAGE="http://glfw.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="examples"

DEPEND="x11-libs/libXrandr
	virtual/opengl"

S=${WORKDIR}/${P}

src_prepare() {
	epatch "${FILESDIR}/${P}"-dyn.patch \
		"${FILESDIR}"/${P}-ldflags.patch
}

src_configure() {
	sh ./compile.sh
}

src_compile() {
	emake -C lib/x11 PREFIX=/usr -f Makefile.x11 all libglfw.pc || die "emake failed"
	if use examples; then
		emake -C examples -f Makefile.x11 || die "emake examples failed"
	fi
}

src_install() {
	dolib.a lib/x11/libglfw.a || die "dolib.a failed"
	dolib.so lib/x11/libglfw.so.2.7.2 || die "dolib.so failed"
	dosym libglfw.so.2.7.2 /usr/$(get_libdir)/libglfw.so

	insinto /usr/$(get_libdir)/pkgconfig
	doins lib/x11/libglfw.pc || die "doins failed"
	insinto /usr/include/GL
	doins include/GL/glfw.h || die "doins failed"
	dohtml -r readme.html
	insinto /usr/share/doc/${PF}/pdf
	doins docs/*.pdf

	if use examples; then
		local f
		local MY_EXAMPLES="boing gears heightmap listmodes mipmaps
			mtbench mthello particles pong3d splitview
			triangle wave"
		local MY_PICS="mipmaps.tga pong3d_field.tga pong3d_instr.tga
			pong3d_menu.tga pong3d_title.tga
			pong3d_winner1.tga pong3d_winner2.tga"

		insinto /usr/share/doc/${PF}/examples

		doins examples/Makefile.x11
		for f in $MY_EXAMPLES; do
			doins examples/${f}.c
		done
		for f in $MY_PICS; do
			doins examples/${f}
		done

		insopts -m0755
		for f in $MY_EXAMPLES; do
			doins examples/${f}
		done
	fi
}
