# docker-ddd

## 概要

[qiitaで書いたDDD備忘録記事のサンプルリポジトリ](https://github.com/unSerori/sample-ddd-gin-api)を動かすDocker環境  
cloneしてスクリプト実行で、自動的にコンテナー作成と開発環境（: またはデプロイ）を行う  

### 環境

Visual Studio Code: 1.88.1  
golang.Go: v0.41.4  
image Golang: go version go1.22.2 linux/amd64  

## インストール

プロジェクトをコンテナーの中にcloneするため、ホストOS上の`~/.ssh/`にGitHubに登録済みの鍵があること

1. Dockerをインストール
2. このリポジトリをclone

    ```bash
    git clone git@github.com:unSerori/docker-ddd.git
    ```

3. envファイル作成
    - `./compose/.env`: compose.ymlでDockerfileに対する引数として使うものや、プロジェクト全体で使う変数

        ```env:.env
        TZ=タイムゾーン: Asia/Tokyo
        MYSQL_DEVELOP_HOST_PORT=MYSQLコンテナの開発用ポート: 3316
        API_DEVELOP_HOST_PORT=APIコンテナの開発用コンテナポート: 1080
        API_DEPLOY_HOST_PORT=80
        HOST_SSH_PATH=ホストOS上のGitHubに登録済みの鍵ファイルの場所: ~/.ssh
        ```

    - `./service/mysql-db/.env.mysql-db`: ビルド時にmysql-db-srvコンテナーにcompose.services.service.env_fileで与える環境変数たち

        ```env:.env.mysql-db
        MYSQL_ROOT_PASSWORD=mysql_serverのルートユーザーパスワード: root
        MYSQL_USER=ユーザー名: ddd_user
        MYSQL_PASSWORD=MYSQL_USERのパスワード: ddd_pass
        MYSQL_DATABASE=使用するdatabase名: ddd_db
        ```

    - `./service/go-api/.env.go-api`: ビルド時にgo-api-srvコンテナーにCOPYされるenvファイル（`コンテナー内にコピーしたいリソースのため、go-api/内に置く`）

        ```env:.env.go-api
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

        詳しくはgo-api-srv上でビルドされる[dddのREADME](https://github.com/unSerori/ddd/blob/main/README.md#env)を参照

4. 開発またはデプロイ用のスクリプトで起動

    ```bash
    # 開発用の設定でビルド
    bash ./cmd/develop-rebuild.sh

    # デプロイ用の設定でビルド
    bash ./cmd/deploy-rebuild.sh
    ```

    その他のスクリプトファイルは[スクリプトファイルたち](#スクリプトファイルたち)

### 環境に入る

1. VS Codeでアタッチ  
    VS CodeのDocker, Remote Development拡張機能をインストール、Dockerタブのコンテナーを右クリックし「Attach Visual Studio Code」でVS Codeの機能をフルに使って開発できる

1. コマンドで入りコマンドラインで作業

    ```bash
    docker exec -it juninry_go-api /bin/bash
    ```

    またはDockerタブのコンテナーを右クリックし「Attach Shell」

### 開発用コンテナー内でSSH通信でGitHubとやりとりする方法

1. コンテナー内でssh-keygenして鍵を生成しGitHubに登録
2. 登録済みのホストの鍵を手動コピーまたはvolumesに追加
3. 開発用ビルドで立ち上がるssh-agentコンテナーを経由してホストOSの鍵を利用する
4. Attach VS Codeでインストールされるvscode-serverを経由してホストOSの鍵を利用する

などがある

1. 不便かつ鍵をコンテナーに置きたくないため割愛
2. コンテナーに置きたくないため割愛
3. 開発コンテナーにアタッチしたときにホストOSの鍵を利用しSSH通信できる  
    .envの`HOST_SSH_PATH`にホストOSの鍵の場所を書く必要がある  
    デフォルトだと`~/.ssh`で、とくにwindowsは`%USERPROFILE%\.ssh`のように書かなければならない  
    ただしAttach VS Code(:4)した際はコンテナーにvscode-serverがインストールされ、$SSH_AUTH_SOCKが上書きされ使えないので、4の方法メインで使うならあまりつかわないかも
4. コーディングするとき便利なAttach VS Codeのssh-agent転送機能を利用してホストOSの鍵を利用できる  
    あらかじめホストOSでssh-agentの起動と鍵の登録を行う必要がある  

    ```bash
    # ssh-agentの起動
    eval $(ssh-agent)
    # 鍵の登録
    ssh-add
    ```

## ディレクトリ構成

TODO: `tree -LFa 3 --dirsfirst`に加筆修正

```txt
./docker-juninry
```

## スクリプトファイルたち

コンテナーを建てたり壊したりする用のスクリプトファイルの説明  
`./cmd/`直下に置いてある

- balus.sh: コンテナーたちを破壊する
- deploy-*: go-apiをデプロイ用に建てるときにつかう
- develop-*: go-apiを開発用に建てるときにつかう
- *-destroy: コンテナーたちを破棄する
- *-pause.sh: コンテナーたちを停止する
- *-reboot.sh: コンテナーたちを再起動する
- *-rebuild.sh: コンテナーたちを再ビルド&起動する
- *-resume.sh: コンテナーたちを再開する

## 開発者

Author:[unSerori]  
Mail:[]
