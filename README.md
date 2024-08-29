# docker-ddd

## 概要

[qiitaで書いたDDD備忘録記事のサンプルリポジトリ](https://github.com/unSerori/ddd)を動かすDocker環境

### 環境

Visual Studio Code: 1.88.1
golang.Go: v0.41.4
image Golang: go version go1.22.2 linux/amd64

## インストール

1. Dockerをインストール
2. このリポジトリをclone

    ```bash
    git clone git@github.com:unSerori/ddd.git
    ```

3. プロジェクトルートにenvファイル作成

    ```env:.env
    MYSQL_ROOT_PASSWORD: mysql_serverのルートユーザーパスワード: root
    MYSQL_USER: ユーザー名: ddd_user
    MYSQL_PASSWORD: MYSQL_USERのパスワード: ddd_pass
    MYSQL_DATABASE: 使用するdatabase名: ddd_db
    TZ: タイムゾーン: Asia/Tokyo
    CONTAINER_PASS_FOR_SSH_AGENT: 開発用コンテナがssh-agentコンテナを介してgithubとssh接続するときに、ssh-agentコンテナが開発用コンテナにパスワードssh接続するためのパスワード: container_pass_for_ssh_agent
    ```

4. 開発またはデプロイ用のスクリプトで起動

    ```bash
    bash TODO:
    ```

    その他のスクリプトファイルは[スクリプトファイルたち](#スクリプトファイルたち)

## スクリプトファイルたち

TODO: コンテナーを建てたり壊したりする用のスクリプトファイルの説明

- start.sh: a

## 開発者

Author:[unSerori]
Mail:[]
