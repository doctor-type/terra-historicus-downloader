#!/bin/bash
set -eu

# $TH_URL="https://terra-historicus.hypergryph.com/"

mkdir -p ./terra-historicus-downloader/

readonly INPUT=${1}

readonly PAGE_LIST_API=$(echo $INPUT | sed s#/comic#/api/comic#g)

readonly PAGE_LIST_JSON=$(curl --silent $PAGE_LIST_API)

readonly PAGE_COUNT=$(echo $PAGE_LIST_JSON | jq '.data.pageInfos | length')

readonly PAGE_DETAIL_API=${PAGE_LIST_API}"/page?pageNum="

for i in $(seq 1 ${PAGE_COUNT}); do
  image_url=$(curl --silent "$PAGE_DETAIL_API$i" | jq --raw-output '.data.url')
  curl --silent $image_url --output ./terra-historicus-downloader/${i}.jpeg
done
