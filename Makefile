# Really Shitty Patchweasel Makefile
#
# mikeg@bsd-box.net

## This version will be sub'd into the main Patchweasel script.
VERSION=	1.0.1

## Which PatchWeasel drivers to install
## May be overridden by the user.
DRIVERS?=	EXAMPLE freebsd-update radmind

PREFIX?=	/usr/local

ETCDIR=		${DESTDIR}${PREFIX}/etc
SBINDIR=	${DESTDIR}${PREFIX}/sbin
MANDIR=		${DESTDIR}${PREFIX}/man/man1
DRVDIR=		${DESTDIR}${PREFIX}/libexec/patchweasel/drivers
INSTALL=	install


patchweasel: patchweasel.in
	cat patchweasel.in | sed s/__PWVERSION__/${VERSION}/g > patchweasel
	
all: patchweasel

install: all
	${INSTALL} -d ${SBINDIR}
	${INSTALL} -d ${ETCDIR}
	${INSTALL} -d ${MANDIR}
	${INSTALL} -d ${DRVDIR}
	${INSTALL} -o 0 -g 0 -m 0755 patchweasel ${SBINDIR}/patchweasel
	${INSTALL} -o 0 -g 0 -m 0644 patchweasel.conf ${ETCDIR}/patchweasel.conf.sample
	${INSTALL} -o 0 -g 0 -m 0644 patchweasel.1 ${MANDIR}/patchweasel.1
	@for d in ${DRIVERS}; do \
		${INSTALL} -v -o 0 -g 0 -m 0644 drivers/$${d} ${DRVDIR}/$${d} ; \
 done

clean:
	rm -f patchweasel

dist: clean
	tar -cvjf patchweasel-${VERSION}.tar.bz2 --exclude 'patchweasel-*.tar.bz2' --exclude-vcs .

