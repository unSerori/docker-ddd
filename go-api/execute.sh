#!/bin/bash

# 停止シグナルのハンドル
stop_handler() {
    echo "Terminating process with PID: ${MAIN_PID}..."
    kill -s TERM $MAIN_PID
    wait $MAIN_PID
    echo "Process with PID: ${MAIN_PID} has been terminated."
}

# シグナルハンドリング
trap stop_handler SIGTERM SIGINT

# change work dir
sh_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)" # 実行場所を相対パスで取得し、そこにサブシェルで移動、pwdで取得
cd "$sh_dir" || {
    echo "Failure CD command."
    exit 1
}

# log
echo "DATE: $(date)" 2>&1 | tee -a /root/log/log.log # datetime
echo "PWD: $(pwd)" 2>&1 | tee -a /root/log/log.log   # /root/copy
echo "Checking directories: /root/" 2>&1 | tee -a /root/log/log.log
find /root/ -maxdepth 0 -exec ls -la {} + 2>&1 | tee -a /root/log/log.log # ls -la /root/
echo "Checking directories: /root/ddd" 2>&1 | tee -a /root/log/log.log
find /root/ddd -maxdepth 0 -exec ls -la {} + 2>&1 | tee -a /root/log/log.log # ls -la /root/ddd/

# volumesされているはずのディレクトリが空(初回ビルド時)なら、
if [ -d "/root/ddd/" ] && [ -z "$(ls -A "/root/ddd/")" ]; then # -dでディレクトリかどうか確認し、かつ、-zでls -Aによるリスト化したフォルダ内のリストが空なら真
    # log
    echo Clone now... 2>&1 | tee -a /root/log/log.log

    # ソースコードのリポジトリをクローン、
    git clone https://github.com/unSerori/ddd.git /root/ddd/./
    # copyされたファイルを適切な場所に移行
    mv .env /root/ddd/
else
    # log
    echo Do not clone. 2>&1 | tee -a /root/log/log.log
fi

# log
echo End of clone process branch. 2>&1 | tee -a /root/log/log.log
echo Start main process... 2>&1 | tee -a /root/log/log.log
echo -e -n "\n" 2>&1 | tee -a /root/log/log.log

# メインプロセス(SSHサーバーで起動)を実行
/usr/sbin/sshd -D &
# メインプロセスのPIDを取得
MAIN_PID=$!
echo "\$MAIN_PID: ${MAIN_PID}"

# 子プロセスの終了を待つ
wait $MAIN_PID
