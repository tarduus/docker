

. ./env.sh

TAG=
if [ -e ./.tag ]; then
	TAG=`cat ./.tag`
fi


# run the docker image
docker run -it --rm \
	--privileged \
	--hostname ${DOCKER_HOSTNAME} \
	--name ${DOCKER_CONTAINER} \
    --volume ${HOME}:${HOME} \
	"${DOCKER_IMAGE_TAG}${TAG}" \
	/bin/bash
