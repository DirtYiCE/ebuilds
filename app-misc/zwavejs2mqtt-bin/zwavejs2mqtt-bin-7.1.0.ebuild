EAPI=8

DESCRIPTION="Zwave to Mqtt gateway and Control Panel Web UI"
HOMEPAGE="https://zwave-js.github.io/zwavejs2mqtt/"
SRC_URI="https://github.com/zwave-js/zwavejs2mqtt/releases/download/v${PV}/zwavejs2mqtt-v${PV}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="
	acct-group/zwavejs2mqtt
	acct-user/zwavejs2mqtt
"
RDEPEND="!app-misc/zwavejs2mqtt"

S="${WORKDIR}"

src_install() {
	dobin zwavejs2mqtt
	newinitd "${FILESDIR}/init" zwavejs2mqtt
	keepdir /var/lib/zwavejs2mqtt
	fowners -R zwavejs2mqtt:zwavejs2mqtt /var/lib/zwavejs2mqtt
	keepdir /var/log/zwavejs2mqtt
	fowners -R zwavejs2mqtt:zwavejs2mqtt /var/log/zwavejs2mqtt
}
