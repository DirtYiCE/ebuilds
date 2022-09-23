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
RDEPEND=">=dev-python/fkf-garbage-collection-0.5.0"

src_install() {
	insinto "/etc/homeassistant/www/${PN}"
	doins dist/*

	fowners -R homeassistant:homeassistant /etc/homeassistant
}
