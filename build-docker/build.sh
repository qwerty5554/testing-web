#!/bin/sh
echo "Build started"
cd $(dirname $0)/.. || exit 1
set -e
DOCKER_BUILDKIT=1 docker build -f build-docker/Dockerfile -t ${CI_REGISTRY_IMAGE}:${CI_COMMIT_REF_NAME} --build-arg branch=${CI_COMMIT_REF_NAME} . || (echo "Build failed" && exit 1)
set +e

echo "Push to GitLab Registry"
echo "$CI_REGISTRY_PASSWORD" | docker login $CI_REGISTRY -u "$CI_REGISTRY_USER" --password-stdin
docker push ${CI_REGISTRY_IMAGE}:${CI_COMMIT_REF_NAME}
# also push with hash version for history
docker tag ${CI_REGISTRY_IMAGE}:${CI_COMMIT_REF_NAME} ${CI_REGISTRY_IMAGE}:${CI_COMMIT_SHORT_SHA}
docker push ${CI_REGISTRY_IMAGE}:${CI_COMMIT_SHORT_SHA}
[ $? -eq 0 ] && echo "Build done" || (echo "Build failed" && exit 1)
