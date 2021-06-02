#!/bin/sh -l

IMAGE_NAME="$INPUT_GCR_HOST/$INPUT_GCR_PROJECT_ID/$INPUT_DOCKER_IMAGE_NAME:$INPUT_DOCKER_IMAGE_TAG"

echo $INPUT_GCR_SERVICE_KEY | docker login -u _json_key --password-stdin https://$INPUT_GCR_HOST/
if [ -z "$INPUT_BUILD_ARGS" ]
then
      docker build -t $IMAGE_NAME -f $INPUT_DOCKERFILE $INPUT_DOCKER_CONTEXT
else
      docker build -t $IMAGE_NAME -f --build-arg $INPUT_BUILD_ARGS $INPUT_DOCKERFILE $INPUT_DOCKER_CONTEXT
fi

docker push $IMAGE_NAME
