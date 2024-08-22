#!/usr/bin/env bash
#
# Based on "upload-github-release-asset.sh" by Stefan Buck
# https://gist.github.com/stefanbuck/ce788fee19ab6eb0b4447a85fc99f447

set -euo pipefail

repo_owner=bocoup
repo_name=at-driver-servers
tag_version=$(node -p "require('./package.json').version")
tag_name="v${tag_version}"
package_name=$(npm pack)

# Define variables.
gh_api="https://api.github.com"
repo_address="$gh_api/repos/$repo_owner/$repo_name"
gh_tags="$repo_address/releases/tags/$tag_name"
auth="Authorization: token $GITHUB_API_TOKEN"

# Validate token.
curl -o /dev/null -sH "$auth" $repo_address || \
  { echo "Error: Invalid repo, token or network issue!" >&2; exit 1; }

echo "Crating release \"${tag_name}\"..."

response=$(curl -L \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: token $GITHUB_API_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  ${repo_address}/releases \
  -d '{"tag_name":"'${tag_name}'","name":"'${tag_name}'","body":"Description of the release","draft":false,"prerelease":false,"generate_release_notes":false}')

id=$(echo $response | python3 -c 'import json; import sys; print(json.loads(sys.stdin.read())["id"])')

# Upload asset
echo "Uploading asset \"${package_name}\"..."

# Construct url
GH_ASSET="https://uploads.github.com/repos/$repo_owner/$repo_name/releases/$id/assets?name=${package_name}"

curl \
  --data-binary @"${package_name}" \
  -H "Authorization: token $GITHUB_API_TOKEN" \
  -H "Content-Type: application/octet-stream" \
  $GH_ASSET
