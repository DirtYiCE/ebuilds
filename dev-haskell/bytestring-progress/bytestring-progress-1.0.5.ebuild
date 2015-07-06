# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

# ebuild generated by hackport 0.4.5

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="A library for tracking the consumption of a lazy ByteString"
HOMEPAGE="http://github.com/acw/bytestring-progress"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+use-system-progressbar"

RDEPEND=">=dev-lang/ghc-7.4.1:=
	use-system-progressbar? ( >=dev-haskell/terminal-progress-bar-0.0.1:=[profile?] <dev-haskell/terminal-progress-bar-0.0.2:=[profile?] )
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.6
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag use-system-progressbar use-system-progressbar)
}