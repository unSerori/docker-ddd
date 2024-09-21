# ベースイメージ
FROM debian:bullseye-slim AS builder

# 作業ディレクトリ
WORKDIR /root/ssh-agent

# ssh接続用のライブラリをインストール
RUN apt-get update && \
    # ssh-agentはopenssh-clientに含まれてて、ssh-agentを使ってSSH接続したいコンテナのための鍵管理を行う
    apt-get install -y openssh-client

# compose.ymlから値を受け取り、エントリーポイントで使う環境変数に定義
ARG SSH_AUTH_SOCK
ENV SSH_AUTH_SOCK_PATH=${SSH_AUTH_SOCK}

# 起動用スクリプトをコピー
COPY ./init.sh ./
RUN chmod +x ./init.sh

# スクリプトで起動
ENTRYPOINT ["./init.sh"]
