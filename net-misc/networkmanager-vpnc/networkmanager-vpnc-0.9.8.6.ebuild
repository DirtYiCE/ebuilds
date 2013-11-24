# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/networkmanager-vpnc/networkmanager-vpnc-0.9.8.6.ebuild,v 1.1 2013/09/16 01:25:43 tetromino Exp $

EAPI=5
GNOME_ORG_MODULE="NetworkManager-${PN##*-}"

inherit eutils gnome2-utils gnome.org

DESCRIPTION="NetworkManager VPNC plugin"
HOMEPAGE="http://www.gnome.org/projects/NetworkManager/"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk2 gnome test"

RDEPEND="
	>=net-misc/networkmanager-0.9.8
	>=dev-libs/dbus-glib-0.74
	>=net-misc/vpnc-0.5
        gtk2? ( >=x11-libs/gtk+-2.0:2 )
	!gtk2? (
		>=x11-libs/gtk+-2.91.4:3
		gnome-base/gnome-keyring
	)
"
DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/intltool
	virtual/pkgconfig
"

src_prepare() {
	# Test will fail if the machine doesn't have a particular locale installed
	sed '/test_non_utf8_import (plugin/ d' \
		-i properties/tests/test-import-export.c || die "sed failed"

	gnome2_disable_deprecation_warning
}

src_configure() {
	econf \
		--disable-more-warnings \
		--disable-static \
		--with-dist-version=Gentoo \
		--with-gtkver=$(usex gtk2 2 3 '' '') \
		$(use_with gnome gnome) \
		$(use_with test tests)
}

src_install() {
	default
	prune_libtool_files
}