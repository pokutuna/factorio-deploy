#!/bin/bash

ROOT=$(cd $(dirname "$0") && cd ../ && pwd)
exec docker-compose -f ${ROOT}/docker/docker-compose.yml up
