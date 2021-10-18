#! /bin/bash
set -e
docker build -t ampr-echolink-base . -f base.dockerfile
docker tag ampr-echolink-base ewpratten/echolink-base
docker push ewpratten/echolink-base