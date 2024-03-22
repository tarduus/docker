
. env.sh


TAG=`date +"%Y-%m-%d"`

docker commit $DOCKER_CONTAINER $DOCKER_IMAGE_TAG:$TAG
