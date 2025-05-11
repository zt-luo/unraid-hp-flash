#!/bin/bash

# Get current version
version=`date +'%Y.%m.%d'`

# To create a token go to: https://github.com/settings/tokens click on Generate
# new token button, select Generate new token (classic) enter you credentials
# enter a Note <- this will be the user name and make sure the token has access
# to: repo:status, public_repo, repo_deployment and workflow
#
#Set your GitHub username either with a file or with variables like:
#export GITHUB_USER=NOTEFROMTOKEN
#export GITHUB_TOKEN=YOURTOKENHERE

#Set variables for GitHub Upload
GITHUB_USERNAME="zt-luo"
GITHUB_REPO_NAME="unraid-hp-flash"
GITHUB_TARGET="master"

# Create tag for release with description
github-release release \
  --user $GITHUB_USERNAME \
  --repo $GITHUB_REPO_NAME \
  --tag "$version" \
  --name "$version" \
  --description "hp-flash plugin package(s) for Unraid by zt-luo"

# Sleep a bit (to avoid upload issues)
sleep 5

# Change to directory where driver package and md5 sum is located
cd out/

# Upload all files in this directory to the before created tag
ls -1 | xargs -n1 -P0 -I{} -- \
github-release upload \
  --user $GITHUB_USERNAME \
  --repo $GITHUB_REPO_NAME \
  --tag "$version" \
  --name {} \
  --file {}
