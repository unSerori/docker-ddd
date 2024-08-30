# docker-ddd

## 概要

[qiitaで書いたDDD備忘録記事のサンプルリポジトリ](https://github.com/unSerori/ddd)を動かすDocker環境

### 環境

Visual Studio Code: 1.88.1  
golang.Go: v0.41.4  
image Golang: go version go1.22.2 linux/amd64  

## インストール

プロジェクトをコンテナーの中にcloneするため、ホストOS上の`~/.ssh/`にGitHubに登録済みの鍵があること

1. Dockerをインストール
2. このリポジトリをclone

    ```bash
    git clone git@github.com:unSerori/ddd.git
    ```

3. プロジェクトルートにenvファイル作成
    - `./env`: compose.ymlでDockerfileに対する引数として使うものや、プロジェクト全体で使う変数

        ```env:.env
        TZ=タイムゾーン: Asia/Tokyo
        CONTAINER_PASS_FOR_SSH_AGENT=開発用コンテナがssh-agentコンテナを介してgithubとssh接続するときに、ssh-agentコンテナが開発用コンテナにパスワードssh接続するためのパスワード: container_pass_for_ssh_agent
        HOST_SSH_PATH=ホストOS上のGitHubに登録済みの鍵ファイルの場所: ~/.ssh
        ```

    - `./.mysql-db-srv.env`: ビルド時にmysql-db-srvコンテナーにcompose.services.service.env_fileで与える環境変数たち

        ```env:.env.mysql-db-srv
        MYSQL_ROOT_PASSWORD=mysql_serverのルートユーザーパスワード: root
        MYSQL_USER=ユーザー名: ddd_user
        MYSQL_PASSWORD=MYSQL_USERのパスワード: ddd_pass
        MYSQL_DATABASE=使用するdatabase名: ddd_db
        ```

    - `./go-api/.env.go-api-srv`: ビルド時にgo-api-srvコンテナーにCOPYされるenvファイル（`コンテナー内にコピーしたいリソースのため、go-api/内に置く`）

        ```env:.env.go-api-srv
        MYSQL_USER=DBに接続する際のログインユーザ名: ddd_user
        MYSQL_PASSWORD=パスワード: ddd_pass
        MYSQL_HOST=ログイン先のDBホスト名（dockerだとサービス名）: mysql-db-srv
        MYSQL_PORT=ポート番号（dockerだとコンテナのポート）: 3306
        MYSQL_DATABASE=使用するdatabase名: ddd_db
        JWT_SECRET_KEY="openssl rand -base64 32"で作ったJWTトークン作成用のキー
        JWT_TOKEN_LIFETIME=JWTトークンの有効期限: 315360000
        MULTIPART_IMAGE_MAX_SIZE=Multipart/form-dataの画像の制限サイズ（10MBなら10485760）: 10485760
        REQ_BODY_MAX_SIZE=リクエストボディのマックスサイズ（50MBなら52428800）: 52428800
        ```

        詳しくはgo-api-srv上でビルドされる[dddのREADME](https://github.com/unSerori/ddd/blob/main/README.md#環境構築)を参照TODO:

4. 開発またはデプロイ用のスクリプトで起動

    ```bash
    # デプロイ用の設定でビルド
    bash TODO:
    ```

    その他のスクリプトファイルは[スクリプトファイルたち](#スクリプトファイルたち)

## スクリプトファイルたち

TODO: コンテナーを建てたり壊したりする用のスクリプトファイルの説明

- start.sh: a

## 開発者

Author:[unSerori]  
Mail:[]
