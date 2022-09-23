EAPI=8

DESCRIPTION="Non-spooling printer daemon"
HOMEPAGE="http://p910nd.sourceforge.net/"
SRC_URI="https://github.com/kenyapcomau/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

src_prepare() {
	eapply -p0 "${FILESDIR}/${P}-file-locations.patch"
	eapply_user
}

src_install() {
	# do not use Makefile as it installs debian centric init scripts
	exeinto /usr/sbin
	doexe p910nd
	doman p910nd.8

	newconfd "${FILESDIR}/conf" p910nd
	newinitd "${FILESDIR}/init" p910nd
}
