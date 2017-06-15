#!/bin/bash
set -e
cd "$(dirname "$0")"
mkdir -p archiv-raw
cd archiv-raw
# HTTrack mit ein paar Filtern:
# Der Filter '-*"*' ist gegen einen Bug in httrack, das dann immer https://fablab.fau.de/bla/"https://fablab.fau.de/foo" ... laden will.
# httrack --continue --update https://fablab.fau.de/ '-fablab.fau.de/wiki/*' '-fablab.fau.de/app/*' '-fablab.fau.de/user/*'  '-fablab.fau.de/comment/reply/*'  '-*"*' '-mime:application/rss+xml'
cd ..

# TODO robots.txt

# copy over to archiv-filtered/
chmod u+rX -R archiv-raw/
test -d archiv-filtered && rm -r archiv-filtered/
cp -r --reflink=auto archiv-raw/ archiv-filtered/

# filter: add extra CSS and JS
for cssfile in archiv-filtered/fablab.fau.de/sites/all/themes/fusion/fusion_core/css/grid16-fluid*.css; do
    cat extra.css >> $cssfile
done

for jsfile in archiv-filtered/fablab.fau.de/sites/fablab.fau.de/files/js/js_*.js; do
    cat extra.js >> $jsfile
done
