
. ./env.sh


docker build --tag "${DOCKER_IMAGE_TAG}" \
			 --build-arg "DOCKER_WORKDIR=${DOCKER_WORKDIR}" \
			 --build-arg "USER=$(whoami)" \
			 --build-arg "host_uid=$(id -u)" \
			 --build-arg "host_gid=$(id -g)" \
			 .

