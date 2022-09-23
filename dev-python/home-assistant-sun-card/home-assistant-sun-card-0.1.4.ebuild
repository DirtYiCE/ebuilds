EAPI=8

DESCRIPTION="Home assistant sun card based on Google weather design"
HOMEPAGE="https://github.com/AitorDB/${PN}"
SRC_URI="https://github.com/AitorDB/${PN}/releases/download/v${PV}/${PN}.js -> ${P}.js"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="
	acct-group/homeassistant
	acct-user/homeassistant
"
RDEPEND="|| ( app-misc/homeassistant app-misc/homeassistant-min app-misc/homeassistant-full )"

S="${WORKDIR}"

src_install() {
	insinto /etc/homeassistant/www
	newins "${DISTDIR}/${P}.js" "${PN}.js"

	fowners -R homeassistant:homeassistant /etc/homeassistant
}
