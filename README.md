# README

## 概要

バージョンアップ確認用。
rspec/gem フォルダに CHANGELOG に書かれている項目の動作確認用テストをまとめる。

## 準備

rbenv インストール

```sh
git clone
```

ruby-build インストール

```sh
git clone
```

Ruby インストール

```sh
rbenv install <所望のバージョン>
rbenv local <所望のバージョン>
rbenv global <所望のバージョン>
```

gem のアップデート

```sh
rbenv exec gem update -system
```

bundler のインストール

```sh
rbenv exec gem install bundler
```

## 使い方

使いたいバージョンのディレクトリに移動

```sh
cd path/to/directory
```

gem のインストール

```sh
bin/bundle install
```

rails のバージョンの確認

```sh
bin/rails -v
```

テストの実行

```sh
bin/bundle exec rspec
```

サンプルの実行

```sh
bin/rails runner <lib/samples中のクラス>.execute
```

## 新しいバージョンを試すとき

rails のバージョンを変更

```sh
rbenv gem uninstall rails
rbenv gem install rails -v '<所望のバージョン>'
rbenv rehash
rails -v
```

rails アプリケーションの新規作成

```sh
rails new <所望のバージョン>
```

作成されたディレクトリに移動

```sh
cd <所望のバージョン>
```

Gemfile の rails のバージョンを指定

```diff_ruby:Gemfile
- gem "rails", "~> 7.0.6"
+ gem "rails", "<所望のバージョン>"
```

Gemfile に rspec-rails を追加

```diff
group :development, :test do
+  gem 'rspec-rails', '~> 6.0.0'
end
```

Gem のインストール

```sh
bin/bundle install
```

RSpec の初期化

```sh
bin/rails g rails:install
```

test フォルダの削除

```sh
rm -r test
```

config/application.rb に lib ディレクトリのロード設定

```diff
class Application < Rails::Application
+   config.eager_load_paths << Rails.root.join("lib")
end
```
