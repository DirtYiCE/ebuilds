# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/audacious/audacious-3.5.1.ebuild,v 1.1 2014/07/31 21:32:03 chainsaw Exp $

EAPI=5
inherit eutils

MY_P="${P/_/-}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Audacious Player - Your music, your way, no exceptions"
HOMEPAGE="http://audacious-media-player.org/"
SRC_URI="http://distfiles.audacious-media-player.org/${MY_P}.tar.bz2
	 mirror://gentoo/gentoo_ice-xmms-0.2.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux"

IUSE="chardet nls gtk2 qt5 valgrind"

RDEPEND=">=dev-libs/dbus-glib-0.60
	>=dev-libs/glib-2.28
	dev-libs/libxml2
	>=x11-libs/cairo-1.2.6
	>=x11-libs/pango-1.8.0
	gtk2? ( x11-libs/gtk+:2 )
	qt5? ( >=dev-qt/qtgui-5.1:5 >=dev-qt/qtcore-5.1:5 >=dev-qt/qtwidgets-5.1:5 )"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	chardet? ( >=app-i18n/libguess-1.2 )
	nls? ( dev-util/intltool )
	valgrind? ( dev-util/valgrind )"

PDEPEND="~media-plugins/audacious-plugins-${PV}[gtk2=,qt5=]"

src_configure() {
	# D-Bus is a mandatory dependency, remote control,
	# session management and some plugins depend on this.
	# Building without D-Bus is *unsupported* and a USE-flag
	# will not be added due to the bug reports that will result.
	# Bugs #197894, #199069, #207330, #208606
	econf \
		--enable-dbus \
		$(use_enable chardet) \
		$(use_enable nls) \
		$(use_enable gtk2 gtk) \
		$(use_enable qt5 qt) \
		$(use_enable valgrind)
}

src_install() {
	default
	dodoc AUTHORS

	# Gentoo_ice skin installation; bug #109772
	insinto /usr/share/audacious/Skins/gentoo_ice
	doins "${WORKDIR}"/gentoo_ice/*
	docinto gentoo_ice
	dodoc "${WORKDIR}"/README
}
