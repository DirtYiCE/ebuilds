EAPI=8

DESCRIPTION="sampling disk usage profiler for btrfs"
HOMEPAGE="https://github.com/CyberShadow/btdu"
SRC_URI="amd64? ( https://github.com/CyberShadow/btdu/releases/download/v${PV}/btdu-static-x86_64 )"
S="${WORKDIR}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64"

QA_PREBUILT="/usr/sbin/btdu"

src_unpack() {
	:;
}

src_install() {
	cp "${DISTDIR}/btdu-static-x86_64" btdu || die
	exeinto /usr/sbin
	doexe btdu
}
