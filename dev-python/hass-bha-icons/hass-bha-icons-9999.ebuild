EAPI=8

inherit git-r3

DESCRIPTION="FKF Budapest Garbage Collection custom component for Home Assistant"
HOMEPAGE="https://github.com/hulkhaugen/${PN}"
EGIT_REPO_URI="https://github.com/hulkhaugen/${PN}.git"

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
	insinto "/etc/homeassistant/www/${PN}"
	doins dist/*

	fowners -R homeassistant:homeassistant /etc/homeassistant
}
