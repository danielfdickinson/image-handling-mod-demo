#!/bin/bash

set -e
set -o pipefail

# Ensure Go modules with LFS checksum correctly
# Workaround for https://github.com/golang/go/issues/41708
git lfs install

bash ./tests/scripts/hugo-audit.sh
bash ./tests/scripts/check-internal-links.sh

rm -rf public exampleSite/public

if [ "$CONTEXT" = "production" ]; then
	export HUGO_PARAMS_DEPLOYEDBASEURL="$URL"
else
	export HUGO_PARAMS_DEPLOYEDBASEURL="$DEPLOY_PRIME_URL"
fi

HUGO_RESOURCEDIR="$(pwd)/resources" hugo --gc --minify -b $HUGO_PARAMS_DEPLOYEDBASEURL
