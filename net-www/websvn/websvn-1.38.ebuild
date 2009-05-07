# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# NOTE: The comments in this file are for instruction and documentation.
# They're not meant to appear with your final, production ebuild.  Please
# remember to remove them before submitting or committing your ebuild.  That
# doesn't mean you can't add your own comments though.

# The 'Header' on the third line should just be left alone.  When your ebuild
# will be committed to cvs, the details on that line will be automatically
# generated to contain the correct data.

inherit webapp

DESCRIPTION="WWW interface to Subversion"
HOMEPAGE="http://websvn.tigris.org"
SRC_URI="http://websvn.tigris.org/files/documents/1380/10659/WebSVN.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE="enscript"

DEPEND=">=dev-util/subversion-1.0.0
		enscript? ( >=app-text/enscript-1.6.3-r1 )"

S=${WORKDIR}/WebSVN

src_compile() {


	# if using enscript, activate it by default
	if use enscript; then
		sed -e 's/\/\/\ \$config->useEnscript();/\$config->useEnscript();/g' \
			${S}/include/distconfig.inc > ${S}/include/distconfig.inc.tmp
		mv -f ${S}/include/distconfig.inc.tmp ${S}/include/distconfig.inc
	fi

	# create default config
	cp ${S}/include/distconfig.inc ${S}/include/config.inc
}

src_install() {
	webapp_src_preinst
	
	local docs="changes.txt install.txt licence.txt templates.txt"
	dodoc ${docs}

	for doc in ${docs}; do
		rm -f ${doc}
	done
	
	# einfo installing app's main files
	cd ${S}
	cp -r * ${D}${MY_HTDOCSDIR}

	# create and identify default configuration file
	webapp_configfile ${MY_HTDOCSDIR}/include/config.inc

	webapp_src_install
}

pkg_postinst() {
	einfo
	einfo "Don't forget to configure apache permissions if you don't"
	einfo "want everyone to be able to read your repository."
	einfo
}
