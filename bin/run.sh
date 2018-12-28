#!/bin/bash

ROOT=$(cd $(dirname "$0") && cd ../ && pwd)
exec docker-compose --no-ansi -f ${ROOT}/docker-compose.yml up
