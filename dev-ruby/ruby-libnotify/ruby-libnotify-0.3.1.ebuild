# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit ruby

MY_P="ruby-libnotify-${PV}"

DESCRIPTION="libnotify bindings for ruby"
HOMEPAGE="http://ruby-libnotify.rubyforge.org/"
SRC_URI="http://rubyforge.org/frs/download.php/16947/${MY_P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
USE_RUBY="ruby18"
DEPEND="x11-libs/libnotify
		dev-ruby/ruby-gtk2"
