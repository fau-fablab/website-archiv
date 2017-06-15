#!/bin/bash
set -e
cd "$(dirname "$0")"
mkdir -p archiv-raw
cd archiv-raw
httrack --update https://fablab.fau.de/ '-wiki*'
cd ..
# TODO replace CSS, remove termine, ...
# or just throw this completely out of the google search index
