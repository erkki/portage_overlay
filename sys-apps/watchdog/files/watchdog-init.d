#!/sbin/runscript
# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/watchdog/files/watchdog-init.d,v 1.1 2006/07/13 17:16:49 phreak Exp $

depend() {
	need localmount
	use logger
}

start() {
	ebegin "Starting watchdog"
	start-stop-daemon --start --quiet --exec /usr/sbin/watchdog \
		-- ${WATCHDOG_OPTS}
	eend ${?}
}

stop() {
	ebegin "Stopping watchdog"
	start-stop-daemon --stop --retry 5 --quiet --exec /usr/sbin/watchdog
	eend ${?}
}
