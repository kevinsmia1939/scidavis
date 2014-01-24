version=$1
delta=${version##*.[CD]}
branch=${version%%.*}
scidavis_version=$[$branch*65536 + $delta]
cat >scidavis/src/version.cpp <<EOF
#include "globals.h"
const int SciDAVis::scidavis_versionNo = $scidavis_version;
const char* SciDAVis::scidavis_version = "$version";
const char * SciDAVis::release_date = "`date +"%b %d, %Y"`";
EOF

# also check that all translation files have been included
for i in scidavis/translations/*.ts; do
    if aels -terse $i |grep -- \--- >/dev/null; then
        echo "translation $i not checked in"
        exit 1
        fi
done
