#!/usr/bin/bash
set -eu

# $TH_URL="https://terra-historicus.hypergryph.com/"

mkdir ./terra-historicus-downloader/

readonly INPUT=${0}

readonly PAGE_LIST_API=$(echo $INPUT | sed s#/comic#/api/comic#g)

readonly PAGE_LIST_JSON=$(curl --silent $api)

readonly PAGE_COUNT=$(echo $PAGE_LIST_JSON | jq '.data.pageInfos | length')

readonly PAGE_DETAIL_API=${INPUT}"/page?pageNum="

for $i in $(seq 1 ${PAGE_COUNT}); do
  image_url=$(curl "$page_api$i" | jq '.data.url')
  curl --silent $image_url --output ./terra-historicus-downloader/${i}.jpeg
done
