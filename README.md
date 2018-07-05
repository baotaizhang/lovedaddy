# LoveDaddy

オンライン交際倶楽部

## Version

```
Ruby:  2.5.1
Rails: 5.2.0
```

## Config

- `gem config` を使用
- `config/settings.yml` には環境変数を使って記述する
- `config/settings.local.yml` にはローカルで使う場合の定義を記述する
- `.env.example` を `.env` にリネームコピーして各自設定
- JS/CSSライブラリ管理には `yarn` を使用

## Setup yarn

### Mac

```
$ brew update
$ brew install yarn
```

### 使い方

```
# 新しくjQueryを入れる場合
$ yarn add jquery
# jQueryを削除する場合
$ yarn remove jquery
# バージョンを指定して入れる場合
$ yarn add bootstrap@4
```

追加したライブラリ（node_module配下）はprecompile対象になっている
※全体で読み込ませる場合はマニフェストファイルでも指定すること

```
//= require jquery/dist/jquery
```

## Setup Docker

Docker を使う場合 `./bundle` と `vendor/bundle` は削除しておく

```
$ docker-compose build
$ docker-compose run web rails db:create
$ docker-compose run web rails db:migrate
$ docker-compose run web yarn install
$ docker-compose run --service-ports web
```

## Insert seed date

```
$ bundle exec rake dev:reset
or @docker
$ docker-composer run web rake dev:reset
```

## Deployment Mail

localhost:3000/letter_opener で確認

## Infrastructure

`infrastructure/README.md` 参照

## Deployment instructions

`~/.ssh/config` に以下記載して ssh 接続を確認

```
Host prod-lovedaddy-ctrl
  HostName 54.238.230.145
  User deploy

Host prod-lovedaddy-web
  HostName 10.0.10.179
  User deploy
  ProxyCommand ssh -W %h:%p prod-lovedaddy-ctrl
```

下記コマンドでデプロイする

```
# ステージング
$ bundle exec cap staging deploy

# ステージング（特定のブランチをデプロイ）
$ BRANCH=branch-name bundle exec cap staging deploy

# 本番
$ bundle exec cap production deploy

# 本番タグ付け
$ git tag -a v1.0.0 -m 'v1.0.0 release'
$ git push origin v1.0.0
```
