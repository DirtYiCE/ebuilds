# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit eutils versionator autotools

# NetworkManager likes itself with capital letters
MY_P=${P/networkmanager/NetworkManager}
MYPV_MINOR=$(get_version_component_range 1-2)

DESCRIPTION="NetworkManager StrongSwan plugin."
HOMEPAGE="http://www.strongswan.org/"
SRC_URI="http://download.strongswan.org/NetworkManager/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm ~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=net-misc/networkmanager-0.9
	>=net-misc/strongswan-5.1.0[networkmanager]"

DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	>=x11-libs/gtk+-2.6:2"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}/no-gnome.patch"
	eautoreconf
}

src_configure() {
ECONF="--sysconfdir=/etc --prefix=/usr --libexecdir=/usr/libexec --with-charon=/usr/libexec/ipsec/charon-nm"

econf ${ECONF}
}

src_install() {
emake DESTDIR="${D}" install

dodoc NEWS
}
