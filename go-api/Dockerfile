# デプロイ用のステージ

# Stage1: ビルドのためにgoのイメージ
FROM golang:1.22.2-bullseye AS deploy-builder

# 作業ディレクトリ
WORKDIR /root/ddd/

# 必要なファイルをコピー
COPY .env.go-api-srv ./builder/

# ビルド処理
RUN \
    # 必要ツールのインストール
    apt-get update && \
    apt-get install -y git && \
    # ソースコードのクローン
    git clone https://github.com/unSerori/ddd.git && \
    cp ./builder/.env.go-api-srv ./ddd/.env && \
    # ビルド なお、deploy-builderイメージにgo実行環境が入ってるのでビルドツールのDLは不要
    cd ./ddd && \
    go build -o go-api

# httpポートの公開 ここにクライアントがAPIを投げる
EXPOSE 4561

#ワンファイル化後のディレクトリ操作ハンドルミスによるリカバリ
WORKDIR /root/ddd/ddd

# 本番環境のCMD起動
CMD [ "./go-api" ]
