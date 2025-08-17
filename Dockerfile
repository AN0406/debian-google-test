FROM debian:trixie-slim

# 必要なパッケージをインストール（sudo や bash など）
RUN apt-get update && apt-get install -y \
    sudo \
    bash \
    vim \
    watch \
    python3 \
    make \
    gcc \
    g++ \
    git \
    cmake \
    build-essential \
    wget \
    lcov

ARG USER_NAME
ARG GROUP_NAME
ARG UID
ARG GID

# ユーザーとグループを追加
RUN groupadd -g $GID $GROUP_NAME && \
    useradd -m -u $UID -g $GROUP_NAME -s /bin/bash $USER_NAME && \
    echo "$USER_NAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# コンテナ起動時に実行するスクリプトを指定
COPY setup/setup.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# 作業ディレクトリ
WORKDIR /home/$USER_NAME
# デフォルトのユーザーを設定
USER $USER_NAME

ENTRYPOINT [ "/usr/local/bin/docker-entrypoint.sh" ]