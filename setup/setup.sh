#!/bin/bash

# GoogleTest リポジトリをクローン
if [ ! -d /opt/googletest ]; then
    sudo git clone https://github.com/google/googletest.git /opt/googletest

    # GoogleTest をビルドしてインストール
    cd /opt/googletest
    sudo cmake -S . -B build
    sudo cmake --build build
    sudo cmake --install build
fi

tail -f /dev/null  # コンテナを起動したままにしておく
# この行は、後でコンテナに exec できるようにコンテナを起動したままにしておくためのものです。
# セットアップ後にコンテナを終了させたい場合は、この行を削除してください。