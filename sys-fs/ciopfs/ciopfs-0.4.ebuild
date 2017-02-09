EAPI=6
inherit eutils

DESCRIPTION="case insensitive on purpose file system"
HOMEPAGE="http://www.brain-dump.org/projects/ciopfs/"
SRC_URI="http://www.brain-dump.org/projects/ciopfs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="sys-fs/fuse
	sys-apps/attr
	dev-libs/glib"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/ciopfs-0.4-Makefile.patch

	eapply_user
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install
}
