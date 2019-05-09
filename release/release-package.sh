#!/bin/bash

ref_type=$(jq '.ref_type' ${GITHUB_EVENT_PATH})

if [[ $ref_type == "\"tag"\" ]]
then
  echo "its a tag"
  python setup.py bdist_wheel
  echo "**************"
  ls
  echo "**************"
  ls dist
  exit 0
else
  echo "it is not a tag"
  # do not continue the workflow
  exit 42
fi