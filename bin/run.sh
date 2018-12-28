#!/bin/bash

ROOT=$(cd $(dirname "$0") && cd ../ && pwd)
exec docker-compose --rm -f ${ROOT}/docker-compose.yml up
