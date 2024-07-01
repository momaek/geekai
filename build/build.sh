#!/bin/bash

version=$1
arch=${2:-amd64}

# build go api program
cd ../api
make clean $arch

# build web app
cd ../web
npm run build

cd ../tailweb
npm i
npm run build

cd ../build

# remove docker image if exists
docker rmi -f momaek/geekai-api:$version-$arch
# build docker image for geekai-go
docker build --platform linux/amd64 -t momaek/geekai-api:$version-$arch -f dockerfile-api-go ../

# build docker image for geekai-web
docker rmi -f momaek/geekai-web:$version-$arch
docker build --platform linux/amd64 -t momaek/geekai-api-web:$version-$arch -f dockerfile-vue ../

if [ "$3" = "push" ];then
  docker push momaek/geekai-api:$version-$arch
  docker push momaek/geekai-web:$version-$arch
fi
