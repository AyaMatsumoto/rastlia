FROM ruby:2.5.1

# リポジトリを更新し依存モジュールをインストール
RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       nodejs

# ルート直下にrastliaという名前で作業ディレクトリを作成（コンテナ内のアプリケーションディレクトリ）
RUN mkdir /rastlia
WORKDIR /rastlia

# ホストのGemfileとGemfile.lockをコンテナにコピー
ADD Gemfile /rastlia/Gemfile
ADD Gemfile.lock /rastlia/Gemfile.lock

# bundle installの実行
RUN bundle install

# ホストのアプリケーションディレクトリ内をすべてコンテナにコピー
ADD . /rastlia

# puma.sockを配置するディレクトリを作成
RUN mkdir -p tmp/sockets
