#!/bin/bash

# 削除
docker compose down --rmi all --remove-orphans

# ビルド
DOCKER_BUILDKIT=1 docker compose build --no-cache

# 起動
docker compose up -d
