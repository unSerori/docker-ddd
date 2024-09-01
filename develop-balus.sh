#!/bin/bash

# ボリュームを残して削除

# 破壊
docker compose down --rmi all --remove-orphans
