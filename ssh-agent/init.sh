#!/bin/bash

# ssh agentの起動 # ssh-agentコマンドはプロセスを起動し、環境変数設定値とPIDの出力を行う。evalに出力を解釈させて、設定を行い、シェルとの連携が行えるようにする。
eval "$(ssh-agent)"

# 初回コンテナ起動の処理
if [ -z "$first_flag" ]; then
    echo true

    # フラグを更新
    export first_flag=0

    # 鍵たちの権限変更
    chmod 600 /root/.ssh/*

    # ssh-agentに鍵の登録
    ssh-add
fi

# githubとssh通信したいコンテナにパスワードSSH接続
sshpass -p "${CONTAINER_PASS_FOR_SSH_AGENT}" ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -A "${CONTAINER_NAME}"

# while true; do sleep 3 && echo hoge; done
