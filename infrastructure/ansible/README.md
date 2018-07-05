# Ansible Playbook

## Services
- `Ruby 2.5.1 (by rbenv)`
- `Nginx + Unicorn`

## Prepare
- Amazon Linux であること
- ec2-user で ssh ログインできること

## Setup

Ansible の実行に踏み台サーバーを利用したい場合 `ssh_config` ファイルを生成する

### Shared Setup
- develop, staging, production の ip アドレスを変更
- `group_vars/all` の停止サービスを確認
- `group_vars/all` に必要なユーザーを追記、パスワードは `openssl passwd -1 your-password` で生成
- `roles/common/files/authorized_keys_for_username` の user_name 部分をリネームする、必要ユーザーの数だけファイル作成し公開鍵を追加

### Nginx Setup
- `vars/` 配下のファイルを確認変更

### Ruby
- `vars/` 配下のファイルにバージョン記載

## Usage

### Ruby on Rails Application

```
$ ansible-playbook -v -i production common.yml
$ ansible-playbook -v -i production nginx.yml
$ ansible-playbook -v -i production ruby.yml
$ ansible-playbook -v -i production imagemagick.yml
```

### Tips

Syntax Check

```
$ ansible-playbook -i <hosts> <playbook.yml> --syntax-check
```

Task List

```
$ ansible-playbook -i <hosts> <playbook.yml> --list-tasks
```

Dry Run

```
$ ansible-playbook -i <hosts> <playbook.yml> --private-key="~/.ssh/priv_key.pem" --check
```
