# ベースイメージ
FROM debian:bullseye-slim AS builder

# 作業ディレクトリ
WORKDIR /root/ssh-agent

# ssh接続用のライブラリをインストール
RUN apt-get update \
    && apt-get install -y openssh-server sshpass

# 起動用スクリプトに渡す値を定義
ENV CONTAINER_NAME go-api-srv
ENV CONTAINER_PASS_FOR_SSH_AGENT=${CONTAINER_PASS_FOR_SSH_AGENT}

# 起動用スクリプトをコピー
COPY ./init.sh ./
RUN chmod +x ./init.sh

# スクリプトで起動
ENTRYPOINT ["./init.sh"]
