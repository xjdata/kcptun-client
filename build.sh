#!/bin/bash

docker stop kcptun-client
docker rm kcptun-client
docker rmi xjdata/kcptun-client 

docker build -t xjdata/kcptun-client ./