#!/bin/bash
#
# Script to create an RPM package from the N2 CGI Session 5.2.X source files.
VERSION=$1
RELEASE=$2

set -e

function usage {
    echo " "
    echo "usage: $0 <version> [release]"
    echo " "
    echo "  e.g. $0 5.2.4"
    echo "  Version must be X.Y with optional .Z"
    echo "  Release must be number, default = 1"
    exit 1
}

# Check validity of version numbers.
if [[ -z "$RELEASE" ]]; then RELEASE=1; fi
if [[ ! $VERSION =~ ^[0-9]+\.[0-9]+(\.[0-9]+)?$ ]] || [[ ! $RELEASE =~ ^[0-9]+$ ]]; then
    usage
fi

# Define our base package name. From there we will add some versoning information as required.
N2CGI_SESSION_PACKAGE="n2-cgi-session"
DATE=`date -R`
TAR_N2CGI_SESSION_PACKAGE=${N2CGI_SESSION_PACKAGE}_$VERSION.orig.tar.gz

OUR_DIR=`pwd`
BASEPATH=`dirname "$OUR_DIR"`
BASEDIR=`basename "$BASEPATH"`

SRC_DIR=..
DEPLOY_DIR=../deploy

################################################################################
# Clean up.
echo "# Cleaning up"
./clean.sh

################################################################################
# Create the package distribution setup
rm -rf $DEPLOY_DIR
mkdir $DEPLOY_DIR

# Firstly the base service package.
echo "# Building base package directory to $DEPLOY_DIR/$N2CGI_SESSION_PACKAGE"
cd "$OUR_DIR"
mkdir $DEPLOY_DIR/$N2CGI_SESSION_PACKAGE

# Build the source files for the CGI Session module.
echo "# Compiling: N2 CGI Session Module"
cd "$OUR_DIR/$SRC_DIR/"
perl Makefile.PL

# Fix spacing issues replacing them with tabs so the make script works as expected.
perl -pi -e 's/^  */\t/' Makefile

make
make DESTDIR=$OUR_DIR/$DEPLOY_DIR/$N2CGI_SESSION_PACKAGE/ install

# Remove the pod file.
cd "$OUR_DIR";
rm $DEPLOY_DIR/$N2CGI_SESSION_PACKAGE/usr/lib64/perl5/perllocal.pod

#
# Finally build our RPM package.
#
VERSION=$VERSION \
RELEASE=$RELEASE \
PACKAGE=$N2CGI_SESSION_PACKAGE \
    rpmbuild -v \
    --define "_builddir $OUR_DIR/$DEPLOY_DIR/$N2CGI_SESSION_PACKAGE" \
    --define "_rpmdir %(pwd)/rpms" \
    --define "_srcrpmdir %(pwd)/rpms" \
    --define "_sourcedir %(pwd)/../" \
    -ba n2-cgi-session.spec
