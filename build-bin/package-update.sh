#!/bin/bash
set -o errexit

mkdir -p build/distributions
VERSION=$(cat ganttproject-builder/BUILD-HISTORY-MINOR | tail -n 1 | awk '{print $2}')
[[ -z "$VERSION" ]] && exit 1
echo "Building version $VERSION"
MODULES=$(cat ganttproject-builder/BUILD-HISTORY-MINOR | tail -n 1 | awk '{print $3}')
[[ -z "$MODULES" ]] && exit 1
echo "Will pick these modules: $MODULES"
echo "3.3.$VERSION" > ganttproject-builder/VERSION
gradle clean distbin
cd ganttproject-builder/dist-bin/plugins/
mkdir update-$VERSION
IFS=','
for m in $MODULES; do cp -R base/$m update-$VERSION/ ; done
zip -r ../../../build/distributions/update-$VERSION.zip update-$VERSION