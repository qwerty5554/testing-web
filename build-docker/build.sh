#!/bin/sh
echo "Build started"
cd $(dirname $0)/.. || exit 1
set -e

# Maven с кешем
mvn -Dmaven.repo.local=.m2/repository clean package

# подтянуть прошлый образ (для кеша)
docker pull ${CI_REGISTRY_IMAGE}:${CI_COMMIT_REF_NAME} || true

# сборка с кешем
DOCKER_BUILDKIT=1 docker build \
  --cache-from ${CI_REGISTRY_IMAGE}:${CI_COMMIT_REF_NAME} \
  -t ${CI_REGISTRY_IMAGE}:${CI_COMMIT_REF_NAME} .

# логин и push
docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
docker push ${CI_REGISTRY_IMAGE}:${CI_COMMIT_REF_NAME}

echo "Build done"
