#!/usr/bin/env bash

set -e

#export TRAVIS_COMMIT=1

echo "Set deploy envs"
export GOOGLE_APPLICATION_CREDENTIALS=./gcloud_account_key.json
       GCLOUD_PROJECT_ID=gc-interactivestories-186322
       GCLOUD_CLUSTER_NAME=k8s-cluster
       CLOUDSDK_COMPUTE_ZONE=europe-west3-c

export SPA_IMAGE_NAME=cleverices/dotnetmicroservices.spa
       API_IMAGE_NAME=cleverices/dotnetmicroservices.api
       IDP_IMAGE_NAME=cleverices/dotnetmicroservices.idp
	   DBINITIALIZER_IMAGE_NAME=cleverices/dotnetmicroservices.dbinitializer

echo "create tag reference with commit id on docker images"
docker tag ${SPA_IMAGE_NAME}:$TRAVIS_COMMIT
docker tag ${API_IMAGE_NAME}:$TRAVIS_COMMIT
docker tag ${IDP_IMAGE_NAME}:$TRAVIS_COMMIT
docker tag ${DBINITIALIZER_IMAGE_NAME}:$TRAVIS_COMMIT

echo "Login to Docker Hub"
docker login --username ${DOCKERHUB_USERNAME} --password ${DOCKERHUB_PASSWORD}

echo "Push images to Docker Hub"
docker push ${SPA_IMAGE_NAME}
docker push ${API_IMAGE_NAME}
docker push ${IDP_IMAGE_NAME}
docker push ${DBINITIALIZER_IMAGE_NAME}

echo "Auth on Google Cloud"
gcloud auth activate-service-account --key-file ${GOOGLE_APPLICATION_CREDENTIALS}

echo "Configure gcloud"
gcloud --quiet config set project ${GCLOUD_PROJECT_ID}
gcloud --quiet config set container/cluster ${GCLOUD_CLUSTER_NAME}
gcloud --quiet config set compute/zone ${CLOUDSDK_COMPUTE_ZONE}
gcloud --quiet container clusters get-credentials ${GCLOUD_CLUSTER_NAME}

echo "Update k8s deployments with updated images"
kubectl set image deployment/spa-deployment nginx=${SPA_IMAGE_NAME}:$TRAVIS_COMMIT
kubectl set image deployment/api-deployment app=${API_IMAGE_NAME}:$TRAVIS_COMMIT
kubectl set image deployment/idp-deployment worker=${IDP_IMAGE_NAME}:$TRAVIS_COMMIT