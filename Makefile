# Copyright (c) 2003 Regents of The University of Michigan.
# All Rights Reserved.  See COPYRIGHT.

SHELL = /bin/sh

srcdir = .


prefix=/usr/local
exec_prefix=${prefix}
datarootdir=${prefix}/share
datadir=${datarootdir}
MANDIR=${datarootdir}/man
BINDIR=${exec_prefix}/bin
SBINDIR=${exec_prefix}/sbin

# For server
RADMINDDIR=/var/radmind

# For client
COMMANDFILE=${RADMINDDIR}/client/command.K
CERTDIR=${RADMINDDIR}/cert
PREAPPLYDIR=${RADMINDDIR}/preapply
POSTAPPLYDIR=${RADMINDDIR}/postapply
TLS_CA=${CERTDIR}/ca.pem
TLS_CERT=${CERTDIR}/cert.pem
GNU_DIFF=/usr/bin/diff
ECHO=/bin/echo
MKTEMP=/usr/bin/mktemp
RADMIND_HOST=radmind
RADMIND_AUTHLEVEL=0
RADMIND_MAXCONNECTIONS=0
RADMIND_BUILD_DATE=July 14, 2016
RADMIND_MAIL_DOMAIN=

RADMINDSYSLOG=LOG_LOCAL7

INCPATH=         -I${srcdir}/libsnet -I.
OPTOPTS=	 -Wall -Wmissing-prototypes
CC=		gcc
DEFS=		
LIBS=		-lsnet -lcrypto -lssl -lc -lc  -lpam -lz
LDFLAGS=	-Llibsnet/.libs  ${LIBS}
INSTALL=	/usr/bin/install -c

CFLAGS=		${DEFS} ${OPTOPTS} -g -O2 ${INCPATH}

BINTARGETS=     fsdiff ktcheck lapply lcksum lcreate lmerge lfdiff repo \
		twhich lsort
MAN1TARGETS=    fsdiff.1 ktcheck.1 lapply.1 lcksum.1 lcreate.1 lfdiff.1 \
		lmerge.1 twhich.1 rash.1 repo.1 lsort.1
MAN5TARGETS= 	applefile.5
MAN8TARGETS=	radmind.8
MANTARGETS=	${MAN1TARGETS} ${MAN5TARGETS} ${MAN8TARGETS}
TARGETS=        radmind ${BINTARGETS}

RADMIND_OBJ=    version.o daemon.o command.o argcargv.o code.o \
                cksum.o base64.o mkdirs.o applefile.o connect.o \
		list.o wildcard.o logname.o pathcmp.o tls.o

FSDIFF_OBJ=     version.o fsdiff.o argcargv.o transcript.o llist.o code.o \
                hardlink.o cksum.o base64.o pathcmp.o radstat.o applefile.o \
		list.o wildcard.o

KTCHECK_OBJ=    version.o ktcheck.o argcargv.o retr.o base64.o code.o \
                cksum.o list.o llist.o connect.o applefile.o tls.o pathcmp.o \
		progress.o mkdirs.o report.o rmdirs.o mkprefix.o

LAPPLY_OBJ=     version.o lapply.o argcargv.o code.o base64.o retr.o \
                radstat.o update.o cksum.o connect.o pathcmp.o progress.o \
                applefile.o report.o tls.o mkprefix.o

LCREATE_OBJ=    version.o lcreate.o argcargv.o code.o connect.o progress.o \
                stor.o applefile.o base64.o cksum.o radstat.o tls.o

LCKSUM_OBJ=     version.o lcksum.o argcargv.o cksum.o base64.o code.o \
                progress.o pathcmp.o applefile.o connect.o root.o

LMERGE_OBJ=     version.o lmerge.o argcargv.o code.o pathcmp.o mkdirs.o \
		root.o

LFDIFF_OBJ=     version.o lfdiff.o argcargv.o connect.o retr.o cksum.o \
                progress.o base64.o applefile.o code.o tls.o pathcmp.o \
		transcript.o list.o radstat.o hardlink.o mkprefix.o wildcard.o

REPO_OBJ=	version.o repo.o report.o argcargv.o connect.o code.o tls.o

T2PKG_OBJ=	version.o t2pkg.o argcargv.o transcript.o connect.o code.o \
		hardlink.o cksum.o base64.o pathcmp.o radstat.o applefile.o \
		list.o rmdirs.o mkdirs.o wildcard.o progress.o

TWHICH_OBJ=     version.o twhich.o argcargv.o transcript.o llist.o code.o \
                hardlink.o cksum.o base64.o pathcmp.o radstat.o applefile.o \
		list.o wildcard.o

LSORT_OBJ=     version.o lsort.o pathcmp.o code.o argcargv.o

all : ${TARGETS}

version.o : version.c
	${CC} ${CFLAGS} \
		-DVERSION=\"`cat ${srcdir}/VERSION`\" \
		-c ${srcdir}/version.c

transcript.o : transcript.c
	${CC} ${CFLAGS} \
		-D_RADMIND_PATH=\"${RADMINDDIR}\" \
		-c ${srcdir}/transcript.c

daemon.o : daemon.c
	${CC} ${CFLAGS} \
		-D_RADMIND_AUTHLEVEL=${RADMIND_AUTHLEVEL} \
		-D_RADMIND_PATH=\"${RADMINDDIR}\" \
		-D_RADMIND_LOG=${RADMINDSYSLOG} \
		-D_RADMIND_MAXCONNECTIONS=${RADMIND_MAXCONNECTIONS} \
		-c ${srcdir}/daemon.c

lcksum.o : lcksum.c
	${CC} ${CFLAGS} \
		-D_RADMIND_PATH=\"${RADMINDDIR}\" \
		-c ${srcdir}/lcksum.c

lmerge.o : lmerge.c
	${CC} ${CFLAGS} \
		-D_RADMIND_PATH=\"${RADMINDDIR}\" \
		-c ${srcdir}/lmerge.c

command.o : command.c
	${CC} ${CFLAGS} \
		-c ${srcdir}/command.c

fsdiff.o : fsdiff.c
	${CC} ${CFLAGS} \
		-D_RADMIND_COMMANDFILE=\"${COMMANDFILE}\" \
		-c ${srcdir}/fsdiff.c

lfdiff.o : lfdiff.c
	${CC} ${CFLAGS} \
		-D_PATH_GNU_DIFF=\"${GNU_DIFF}\" \
		-D_RADMIND_COMMANDFILE=\"${COMMANDFILE}\" \
		-D_RADMIND_HOST=\"${RADMIND_HOST}\" \
		-D_RADMIND_AUTHLEVEL=${RADMIND_AUTHLEVEL} \
		-c ${srcdir}/lfdiff.c

ktcheck.o : ktcheck.c
	${CC} ${CFLAGS} \
		-D_RADMIND_PATH=\"${RADMINDDIR}\" \
		-D_RADMIND_HOST=\"${RADMIND_HOST}\" \
		-D_RADMIND_AUTHLEVEL=${RADMIND_AUTHLEVEL} \
		-D_RADMIND_COMMANDFILE=\"${COMMANDFILE}\" \
		-c ${srcdir}/ktcheck.c

lapply.o : lapply.c
	${CC} ${CFLAGS} \
		-D_RADMIND_HOST=\"${RADMIND_HOST}\" \
		-D_RADMIND_AUTHLEVEL=${RADMIND_AUTHLEVEL} \
		-c ${srcdir}/lapply.c

lcreate.o : lcreate.c
	${CC} ${CFLAGS} \
		-D_RADMIND_HOST=\"${RADMIND_HOST}\" \
		-D_RADMIND_AUTHLEVEL=${RADMIND_AUTHLEVEL} \
		-c ${srcdir}/lcreate.c

progress.o : progress.c
	${CC} ${CFLAGS} \
		-c ${srcdir}/progress.c

report.o : report.c
	${CC} ${CFLAGS} \
		-c ${srcdir}/report.c

repo.o : repo.c
	${CC} ${CFLAGS} \
		-D_RADMIND_HOST=\"${RADMIND_HOST}\" \
		-D_RADMIND_AUTHLEVEL=${RADMIND_AUTHLEVEL} \
		-c ${srcdir}/repo.c

root.o : root.c
	${CC} ${CFLAGS} \
		-c ${srcdir}/root.c

t2pkg.o : t2pkg.c
	${CC} ${CFLAGS} \
		-D_RADMIND_COMMANDFILE=\"${COMMANDFILE}\" \
		-D_RADMIND_PATH=\"${RADMINDDIR}\" \
		-c ${srcdir}/t2pkg.c

twhich.o : twhich.c
	${CC} ${CFLAGS} \
		-D_RADMIND_COMMANDFILE=\"${COMMANDFILE}\" \
		-c ${srcdir}/twhich.c

lsort.o : lsort.c
	${CC} ${CFLAGS} \
		-c ${srcdir}/lsort.c

tls.o : tls.c
	${CC} ${CFLAGS} \
		-D_RADMIND_TLS_CA=\"${TLS_CA}\" \
		-D_RADMIND_TLS_CERT=\"${TLS_CERT}\" \
		-c ${srcdir}/tls.c

radmind : libsnet/libsnet.la ${RADMIND_OBJ} Makefile
	${CC} ${CFLAGS} -o radmind ${RADMIND_OBJ} ${LDFLAGS}

fsdiff : ${FSDIFF_OBJ}
	${CC} ${CFLAGS} -o fsdiff ${FSDIFF_OBJ} ${LDFLAGS}

ktcheck: ${KTCHECK_OBJ}
	${CC} ${CFLAGS} -o ktcheck ${KTCHECK_OBJ} ${LDFLAGS}

lapply: ${LAPPLY_OBJ}
	${CC} ${CFLAGS} -o lapply ${LAPPLY_OBJ} ${LDFLAGS}

lcksum: ${LCKSUM_OBJ}
	${CC} ${CFLAGS} -o lcksum ${LCKSUM_OBJ} ${LDFLAGS}

lcreate: ${LCREATE_OBJ}
	${CC} ${CFLAGS} -o lcreate ${LCREATE_OBJ} ${LDFLAGS}

lmerge: ${LMERGE_OBJ}
	${CC} ${CFLAGS} -o lmerge ${LMERGE_OBJ} ${LDFLAGS}

lfdiff: ${LFDIFF_OBJ}
	${CC} ${CFLAGS} -o lfdiff ${LFDIFF_OBJ} ${LDFLAGS}

repo : ${REPO_OBJ}
	${CC} ${CFLAGS} -o repo ${REPO_OBJ} ${LDFLAGS}

t2pkg: ${T2PKG_OBJ}
	${CC} ${CFLAGS} -o t2pkg ${T2PKG_OBJ} ${LDFLAGS}

twhich: ${TWHICH_OBJ}
	${CC} ${CFLAGS} -o twhich ${TWHICH_OBJ} ${LDFLAGS}

lsort: ${LSORT_OBJ}
	${CC} ${CFLAGS} -o lsort ${LSORT_OBJ} ${LDFLAGS}

FRC :

libsnet/libsnet.la : FRC
	cd libsnet; ${MAKE}

VERSION=$(shell date +%Y%m%d)
DISTDIR=../radmind-${VERSION}

dist   : distclean
	mkdir ${DISTDIR}
	tar -h -c -f - -X EXCLUDE . | tar xpf - -C ${DISTDIR}
	echo ${VERSION} > ${DISTDIR}/VERSION
	-mkdir ${DISTDIR}/tmp
	for i in ${MANTARGETS}; do \
	    sed -e 's@_RADMIND_BUILD_DATE@${RADMIND_BUILD_DATE}@g' \
		${DISTDIR}/man/$$i > ${DISTDIR}/tmp/$$i; \
	done
	rm -rf ${DISTDIR}/man
	mv ${DISTDIR}/tmp ${DISTDIR}/man
	tar cvfz ${DISTDIR}.tar.gz ${DISTDIR}

rash : FRC
	-mkdir tmp
	sed -e 's@_RADMIND_HOST@${RADMIND_HOST}@g' \
	    -e 's@_RADMIND_AUTHLEVEL@${RADMIND_AUTHLEVEL}@g' \
	    -e 's@_RADMIND_PREAPPLY@${PREAPPLYDIR}@g' \
	    -e 's@_RADMIND_POSTAPPLY@${POSTAPPLYDIR}@g' \
	    -e 's@_RADMIND_MKTEMP@${MKTEMP}@g' \
	    -e 's@_RADMIND_DIR@${RADMINDDIR}@g' \
	    -e 's@_RADMIND_MAIL_DOMAIN@${RADMIND_MAIL_DOMAIN}@g' \
	    -e 's@_RADMIND_COMMANDFILE@${COMMANDFILE}@g' \
	    -e 's@_RADMIND_VERSION@$(shell cat VERSION)@g' \
	    -e 's@_RADMIND_ECHO_PATH@${ECHO}@g' \
	    ${srcdir}/ra.sh > tmp/ra.sh; 

man : FRC
	-mkdir tmp
	-mkdir tmp/man
	pwd
	for i in ${MANTARGETS}; do \
	    sed -e 's@_RADMIND_PATH@${RADMINDDIR}@g'  \
		-e 's@_RADMIND_COMMANDFILE@${COMMANDFILE}@g' \
		-e 's@_RADMIND_HOST@${RADMIND_HOST}@g' \
		-e 's@_RADMIND_AUTHLEVEL@${RADMIND_AUTHLEVEL}@g' \
		-e 's@_RADMIND_TLS_CA@${TLS_CA}@g' \
		-e 's@_RADMIND_TLS_CERT@${TLS_CERT}@g' \
		-e 's@_RADMIND_MAXCONNECTIONS@${RADMIND_MAXCONNECTIONS}@g' \
		${srcdir}/man/$$i > tmp/man/$$i; \
	done

install	: all man rash
	-mkdir -p ${DESTDIR}/${exec_prefix}
	-mkdir -p ${DESTDIR}/${SBINDIR}
	${INSTALL} -m 0755 -c radmind ${DESTDIR}/${SBINDIR}/
	-mkdir -p ${DESTDIR}/${BINDIR}
	for i in ${BINTARGETS}; do \
	    ${INSTALL} -m 0755 -c $$i ${DESTDIR}/${BINDIR}/; \
	done
	${INSTALL} -m 0755 -c tmp/ra.sh ${DESTDIR}/${BINDIR}/
	-mkdir -p ${DESTDIR}/${prefix}
	-mkdir -p ${DESTDIR}/${MANDIR}
	-mkdir ${DESTDIR}/${MANDIR}/man1
	for i in ${MAN1TARGETS}; do \
	    ${INSTALL} -m 0644 -c tmp/man/$$i ${DESTDIR}/${MANDIR}/man1/; \
	done
	-mkdir ${DESTDIR}/${MANDIR}/man5
	for i in ${MAN5TARGETS}; do \
	    ${INSTALL} -m 0644 -c tmp/man/$$i ${DESTDIR}/${MANDIR}/man5/; \
	done
	-mkdir ${DESTDIR}/${MANDIR}/man8
	 for i in ${MAN8TARGETS}; do \
	    ${INSTALL} -m 0644 -c tmp/man/$$i ${DESTDIR}/${MANDIR}/man8/; \
	done
	-mkdir -p ${DESTDIR}/${RADMINDDIR}/client
	-mkdir -p ${DESTDIR}/${PREAPPLYDIR}
	-mkdir -p ${DESTDIR}/${POSTAPPLYDIR}
	-mkdir -p ${DESTDIR}/${CERTDIR}

PKGNAME=RadmindTools-${VERSION}
PKGDIR=tmp/RadmindToolsInstaller
PKGRSRCDIR=tmp/Resources
PKGSRCDIR=`pwd`

INFOLIST=	$(wildcard OS_X/*.plist)	

info :
	-mkdir tmp
	-mkdir tmp/OS_X
	for i in ${INFOLIST}; do \
	    sed -e 's@_RADMIND_VERSION@${VERSION}@g'  \
		$$i > tmp/$$i; \
	done

package	: all man info rash
	-mkdir -p -m 0755 ${PKGDIR}/${SBINDIR}
	${INSTALL} -m 0755 -c radmind ${PKGDIR}/${SBINDIR}/
	-mkdir -p -m 0755 ${PKGDIR}/${BINDIR}
	for i in ${BINTARGETS}; do \
	    ${INSTALL} -m 0755 -c $$i ${PKGDIR}/${BINDIR}/; \
	done
	${INSTALL} -m 0755 -c tmp/ra.sh ${PKGDIR}/${BINDIR}/
	-mkdir -p -m 0755 ${PKGDIR}/${MANDIR}
	-mkdir -p -m 0755 ${PKGDIR}/${MANDIR}/man1
	for i in ${MAN1TARGETS}; do \
	    ${INSTALL} -m 0644 -c tmp/man/$$i ${PKGDIR}/${MANDIR}/man1/; \
	done
	-mkdir -p -m 0755 ${PKGDIR}/${MANDIR}/man5
	for i in ${MAN5TARGETS}; do \
	    ${INSTALL} -m 0644 -c tmp/man/$$i ${PKGDIR}/${MANDIR}/man5/; \
	done
	-mkdir -p -m 0755 ${PKGDIR}/${MANDIR}/man8
	 for i in ${MAN8TARGETS}; do \
	    ${INSTALL} -m 0644 -c tmp/man/$$i ${PKGDIR}/${MANDIR}/man8/; \
	done
	-mkdir -p -m 0755 ${PKGDIR}${CERTDIR}
	-mkdir -p -m 0755 ${PKGDIR}${PREAPPLYDIR}
	-mkdir -p -m 0755 ${PKGDIR}${POSTAPPLYDIR}
	-mkdir -p -m 0755 ${PKGDIR}${RADMINDDIR}/client
	-mkdir -p -m 0755 ${PKGRSRCDIR}
	${INSTALL} -m 0644 -c OS_X/License.rtf ${PKGRSRCDIR}
	${INSTALL} -m 0644 -c OS_X/ReadMe.rtf ${PKGRSRCDIR}
	${INSTALL} -m 0644 -c OS_X/Welcome.rtf ${PKGRSRCDIR}
	${INSTALL} -m 0644 -c OS_X/background.tiff ${PKGRSRCDIR}
	sudo chown -R root:wheel ${PKGDIR}
	sudo chgrp admin ${PKGDIR}
	/Developer/Applications/Utilities/PackageMaker.app/Contents/MacOS/packagemaker \
	   -build -p ${PKGSRCDIR}/../${PKGNAME}.pkg \
	   -f ${PKGSRCDIR}/${PKGDIR} \
	   -r ${PKGSRCDIR}/${PKGRSRCDIR} \
	   -i ${PKGSRCDIR}/tmp/OS_X/Info.plist \
	   -d ${PKGSRCDIR}/tmp/OS_X/Description.plist
	tar cvfz ../${PKGNAME}.pkg.tar.gz ../${PKGNAME}.pkg
	sudo rm -rf ${PKGDIR}

clean :
	(cd libsnet; ${MAKE} clean)
	rm -f *.o a.out core
	rm -f ${TARGETS}
	rm -rf tmp

distclean: clean
	rm -f config.log config.status Makefile config.h
	rm -rf autom4te.cache
	rm -rf .#*
	cd libsnet; make distclean
