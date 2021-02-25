#!/bin/bash

CLEAN=''
while getopts ":c" opt; do
  case $opt in
    c)
      CLEAN="true"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

echo ">> Remove all containers"
while read -r ID; do
  docker container kill ${ID} 2>/dev/null || echo "${ID} already killed"
  docker container rm -f ${ID}
done < <(docker container ls -aq)

# Only if -c is set and volumes for the current docker-compose exist, then...
docker_compose_root_directory=$(basename $PWD)
if [[ ${CLEAN} == "true" ]] && docker volume ls | grep -q "${docker_compose_root_directory}"; then
    # loop around the volumes specified in docker-compose.yaml and delete each one
    echo ">> ALSO clean all volumes"
    while read -r volume_tag; do
      volume_name="${docker_compose_root_directory}_${volume_tag}"
      docker volume rm ${volume_name} 2>/dev/null || echo "${volume_name} volume already deleted"
    done < <(yq eval '.volumes' docker-compose.yaml | grep -v driver | sed 's|:||g')
fi