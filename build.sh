#!/bin/bash

# 清除已有的
docker stop kcptun-client
docker rm kcptun-client
docker rmi xjdata/kcptun-client 

# 重新生成
docker build -t xjdata/kcptun-client ./
