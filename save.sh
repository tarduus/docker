
. env.sh


TAG=`date +"%Y-%m-%d"`

docker save -o $DOCKER_IMAGE_TAG.$TAG.tar $DOCKER_IMAGE_TAG:latest
