EAPI=8

DESCRIPTION="Use icons from fontawesome in home-assistant"
HOMEPAGE="https://github.com/thomasloven/${PN}"
SRC_URI="https://github.com/thomasloven/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
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
