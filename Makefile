PROJECT = jquery.autoellipsis

SOURCEDIR = src
DISTDIR = dist

UGLIFY ?= `which uglifyjs`

BASEFILES = ${SOURCEDIR}/${PROJECT}.js

VERSION = ${shell cat version.txt}

DISTFILE = ${DISTDIR}/${PROJECT}-${VERSION}.js
DISTMINFILE = ${DISTDIR}/${PROJECT}-${VERSION}.min.js

all: build minify jsdoc

clean:
	@@rm -rf ${DISTDIR}

build: ${DISTFILE}

minify: build ${DISTMINFILE}

jsdoc: ${DISTJSDOC}

${DISTDIR}:
	@@mkdir -p ${DISTDIR}

${DISTFILE}: ${BASEFILES} | ${DISTDIR}
	@@echo "Building" ${DISTFILE};

	@@cat ${BASEFILES} \
		> ${DISTFILE};

${DISTMINFILE}: uglifyavailable ${DISTFILE}
	@@echo "Minifying" ${DISTMINFILE};

	@@ ${UGLIFY} ${DISTFILE} > ${DISTMINFILE};

uglifyavailable: 
	@@if test -z ${UGLIFY}; then \
		echo "You must have UglifyJS installed"; \
		echo "  install with:"; \
		echo "  npm install uglify-js"; \
		exit 1; \
	fi

