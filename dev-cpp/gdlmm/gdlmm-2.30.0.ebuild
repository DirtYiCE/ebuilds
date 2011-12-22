# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libsexymm/libsexymm-0.1.9.ebuild,v 1.8 2011/04/10 16:46:31 ssuominen Exp $

EAPI="3"

inherit gnome2

DESCRIPTION="C++ Bindings for gdl"
HOMEPAGE="http://ftp.gnome.org/pub/GNOME/sources/gdlmm/2.30/"
SRC_URI="http://ftp.gnome.org/pub/GNOME/sources/gdlmm/2.30/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="doc"

RDEPEND=">=dev-cpp/glibmm-2.4:2
		 >=dev-cpp/gtkmm-2.4:2.4
		 >=x11-libs/gdl-2.30.0"
DEPEND="${RDEPEND}
		dev-util/pkgconfig"

pkg_setup() {
	G2CONF="${G2CONF} --disable-static"
}

src_install() {
	gnome2_src_install
	find "${ED}" -name '*.la' -exec rm -f {} +
}
