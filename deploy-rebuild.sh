#!/bin/bash

# 最初の起動や更新の反映に使う
# 既存のイメージやキャッシュを破棄してビルド&起動し直す

# 既存のコンテナの停止とそのイメージの削除 --remove-orphans: Compose ファイルで定義していないサービス用のコンテナも削除
docker compose down --rmi all --remove-orphans --timeout 15

# キャッシュなしでビルド
DOCKER_BUILDKIT=1 docker compose -f compose.yml -f compose.deploy.yml build --no-cache

# 起動
DOCKER_BUILDKIT=1 docker compose -f compose.yml -f compose.deploy.yml up -d
