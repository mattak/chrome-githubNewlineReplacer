#!/bin/bash

set -eu

VERSION=$(jq -r '.version' src/manifest.json)
echo "Version: ${VERSION}"

TARGET_DIR="chrome-githubNewlineReplacer-v${VERSION}"
TARGET_ZIP="chrome-githubNewlineReplacer-v${VERSION}.zip"

# ビルドとzipファイルの作成
rm -rf dist/ 
tsc
cp src/manifest.json dist/ 
cp -r src/icons dist/ 
mv dist ${TARGET_DIR}
zip -r ${TARGET_ZIP} ${TARGET_DIR}
rm -rf ${TARGET_DIR}

echo "Created: ${TARGET_ZIP}"

# タグの作成と push
git tag "v${VERSION}"
git push origin "v${VERSION}"

# GitHub Release の作成
gh release create "v${VERSION}" \
  --title "v${VERSION}" \
  --notes "Release v${VERSION}" \
  "${TARGET_ZIP}"

echo "Created GitHub Release: v${VERSION}"
