#!/bin/bash

set -eu

VERSION=$(jq -r '.version' src/manifest.json)
echo "Version: ${VERSION}"

TARGET_DIR="chrome-githubNewlineReplacer-v${VERSION}"
TARGET_ZIP="chrome-githubNewlineReplacer-v${VERSION}.zip"

rm -rf dist/ 
tsc
cp src/manifest.json dist/ 
cp -r src/icons dist/ 
mv dist ${TARGET_DIR}
zip -r ${TARGET_ZIP} ${TARGET_DIR}
rm -rf ${TARGET_DIR}

echo "Created: ${TARGET_ZIP}"
