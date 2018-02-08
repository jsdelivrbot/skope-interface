#!/bin/bash

set -e

# Get current directory.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
APP_DIR="${DIR}/../meteor-app"

# Read version tag from the npm package file, if not provided.
JS="\
var npmInfo = require('${APP_DIR}/package.json');\
var packageVersion = npmInfo.version;\
console.log(packageVersion);\
"
TAG=${TAG:-$(echo $JS | node)}
ORG_NAME="openskope/web-app"
IMAGE_NAME="${ORG_NAME}:${TAG}"

printf "Image will be tagged as “%s”.\n" "${IMAGE_NAME}"

(
  cd "${APP_DIR}"
  NODE_VER=$(meteor node --version)

  printf "Meteor Node version: %s.\n" "${NODE_VER}"

  printf "Building production bundle...\n"

  meteor npm install --production --unsafe-perm && \
  meteor build --architecture os.linux.x86_64 "${DIR}"
)

docker build -t "${IMAGE_NAME}" "${DIR}"

docker images -a --format "{{.ID}} {{.Repository}}:{{.Tag}} ({{.Size}})" | grep "${IMAGE_NAME}"
