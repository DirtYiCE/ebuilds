EAPI=5

inherit eutils

DESCRIPTION="Non-spooling printer daemon"
HOMEPAGE="http://p910nd.sourceforge.net/"
SRC_URI="mirror://sourceforge/p910nd/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

src_patch() {
	epatch "${FILESDIR}/${P}-file-locations.patch"
}

src_install() {
	# do not use Makefile as it installs debian centric init scripts
	exeinto /usr/sbin
	doexe p910nd
	doman p910nd.8

	newconfd "${FILESDIR}/conf" p910nd
	newinitd "${FILESDIR}/init" p910nd
}
