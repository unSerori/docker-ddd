#!/bin/bash

# ボリュームを残して削除

# 破壊
docker compose -f compose.yml -f compose.develop.yml down --rmi all --remove-orphans --volumes
