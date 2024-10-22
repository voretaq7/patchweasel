# Really Shitty Patchweasel Makefile
#
# mikeg@bsd-box.net

VERSION=	1.0.0

PREFIX?=	/usr/local
DRIVERS=	EXAMPLE radmind

ETCDIR=		${PREFIX}/etc
SBINDIR=	${PREFIX}/sbin
MANDIR=		${PREFIX}/man/man1
DRVDIR=		${PREFIX}/libexec/patchweasel/drivers
INSTALL=	install

all:

install:
	${INSTALL} -d ${SBINDIR}
	${INSTALL} -d ${ETCDIR}
	${INSTALL} -d ${MANDIR}
	${INSTALL} -d ${DRVDIR}
	${INSTALL} -o 0 -g 0 -m 0755 patchweasel ${SBINDIR}/patchweasel
	${INSTALL} -o 0 -g 0 -m 0644 patchweasel.conf ${ETCDIR}/patchweasel.conf.sample
	${INSTALL} -o 0 -g 0 -m 0644 patchweasel.1 ${MANDIR}/patchweasel.1
.for d in ${DRIVERS}
	${INSTALL} -v -o 0 -g 0 -m 0644 drivers/${d} ${DRVDIR}/${d}
.endfor

dist:
	tar -cvjf patchweasel-${VERSION}.tar.bz2 --exclude 'patchweasel-*.tar.bz2' --exclude-vcs .
