#!/bin/bash

ref_type=$(jq '.ref_type' ${GITHUB_EVENT_PATH})
tag_name=$(jq '.ref' ${GITHUB_EVENT_PATH})
target_commitish=$GITHUB_SHA
release=`echo "release-${tag_name}" | sed 's/"//g'`

generate_release()
{
  cat <<EOF
{
  "tag_name": $tag_name,
  "target_commitish": "$target_commitish",
  "name": "${release}",
  "body": $tag_name,
  "draft": false,
  "prerelease": false
}
EOF
}

if [[ $ref_type == "\"tag"\" ]]
then
  echo "sending data ->"
  echo "$(generate_release)"
  echo "to this URL ->"
  echo "https://api.github.com/repos/$GITHUB_REPOSITORY/releases?access_token=NOOOOOOO"
  echo "Creating release"

  response=$(curl --data "$(generate_release)" "https://api.github.com/repos/$GITHUB_REPOSITORY/releases?access_token=$GITHUB_TOKEN")
  assets_url=$(jq '.assets_url' response)
  echo $assets_url

  assets=$(curl $assets_url)
  echo $assets
  exit 0
else
  echo "Not a tag - will not try to release"
  # do not continue the workflow
  exit 0
fi
