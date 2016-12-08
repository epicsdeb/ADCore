#!/bin/sh
set -e -x

# tar file generated from AD git repo with the following incantation
# which strips out unused IDL with .dll, JCA and CAJ jars, and bundled source
# for jpeg, tiff, tinyxml, nexus, and netcdf.

die() {
  echo "$1" >&2
  exit 1
}

# tag or branch name, or rev. hash
TREE="$1"
# version number in output file name
VER="$2"

[ "$TREE" -a "$VER" ] || die "Usage: $0 <TREE> <VERSION>"

(git ls-files --with-tree="${TREE}"|egrep -v 'gitignore|tinyxml|netCDFSrc/|nexusSrc/|tiffSupport/|IDL/|jar' \
 | xargs git archive --prefix=epics-adcore-${VER}/ ${TREE} \
)|gzip -9 > epics-adcore_${VER}.orig.tar.gz
