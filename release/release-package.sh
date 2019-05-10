#!/bin/bash

ref_type=$(jq '.ref_type' ${GITHUB_EVENT_PATH})
tag_name=$(jq '.ref' ${GITHUB_EVENT_PATH})
target_commitish=$GITHUB_REF
release="release-${tag_name}"
body="release-${tag_name}"

generate_release()
{
  cat <<EOF
{
  "tag_name": "$tag_name",
  "target_commitish": "$target_commitish",
  "name": "$release",
  "body": "$text",
  "draft": false,
  "prerelease": false
}
EOF
}

if [[ $ref_type == "\"tag"\" ]]
then
  echo "Creating release"
  curl --data "$(generate_release)" "https://api.github.com/repos/$GITHUB_REPOSITORY/releases?access_token=$GITHUB_TOKEN"

  exit 0
else
  echo "it is not a tag"
  # do not continue the workflow
  exit 0
fi