EAPI=8

DESCRIPTION="FKF Budapest Garbage Collection custom component for Home Assistant"
HOMEPAGE="https://github.com/amaximus/${PN}"
SRC_URI="https://github.com/amaximus/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="
	acct-group/homeassistant
	acct-user/homeassistant
"
RDEPEND="|| ( app-misc/homeassistant app-misc/homeassistant-min app-misc/homeassistant-full )"

src_install() {
	insinto /etc/homeassistant
	doins -r custom_components

	fowners -R homeassistant:homeassistant /etc/homeassistant
}
