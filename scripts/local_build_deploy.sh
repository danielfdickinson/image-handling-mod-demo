#!/bin/bash

set -e
set -o pipefail

rm -rf public

URL="https://www.image-handling-mod.wtg-demos.ca/"
export HUGO_PARAMS_DEPLOYEDBASEURL="$URL"
export BASEURL="$URL"

HUGO_RESOURCEDIR="$(pwd)/resources" hugo --gc --minify -b $BASEURL
rclone sync --progress public/ wtg-deml:image-handling-mod/
