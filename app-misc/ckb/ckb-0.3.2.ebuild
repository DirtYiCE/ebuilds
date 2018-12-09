EAPI=5

inherit cmake-utils linux-info

DESCRIPTION="RGB Driver for Linux and macOS"
HOMEPAGE="https://github.com/ckb-next/ckb-next"
SRC_URI="https://github.com/ckb-next/ckb-next/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-libs/quazip-0.7.2[qt5(+)]
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5"
RDEPEND="${DEPEND}"

DOCS=( README.md )

CONFIG_CHECK="INPUT_UINPUT"

S="${WORKDIR}/ckb-next-${PV}"

src_prepare() {
	epatch "${FILESDIR}/udev-dest.patch"
}

src_configure() {
	local mycmakeargs=(-DDISABLE_UPDATER=1)
	cmake-utils_src_configure
}
