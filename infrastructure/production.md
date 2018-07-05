# ネットワーク

```
   +---- VPC --------------------+
   |                             |
=> IG  => Control-srv            |
   |   |            |            |
   |   =>  ALB <=> Web <=> RDS   |
   |                |            |
   +----------- NAT GW ----------+

                          S3  SES
```

VPC
```
prod-lovedaddy-vpc 10.0.0.0/16
```

Subnet
```
prod-lovedaddy-alb-az1 10.0.1.0/24
prod-lovedaddy-alb-az2 10.0.2.0/24
prod-lovedaddy-web-az1 10.0.10.0/24
prod-lovedaddy-web-az2 10.0.11.0/24
prod-lovedaddy-rds-az1 10.0.20.0/24
prod-lovedaddy-rds-az2 10.0.21.0/24
prod-lovedaddy-nat     10.0.30.0/24
prod-lovedaddy-ctrl    10.0.40.0/24
```

Internet GW
```
prod-lovedaddy-gw-public
VPC にアタッチ
```

NAT GW
```
prod-lovedaddy-gw-private
EIP 13.115.3.195
```

ルートテーブル
```
prod-lovedaddy-rtb-public
0.0.0.0/0 => prod-lovedaddy-gw-public
関連付け   => prod-lovedaddy-ctrl
             prod-lovedaddy-alb-az1
             prod-lovedaddy-alb-az2
             prod-lovedaddy-nat

prod-lovedaddy-rtb-private
0.0.0.0/0 => prod-lovedaddy-gw-private
関連付け   => prod-lovedaddy-web-az1 10.0.10.0/24
             prod-lovedaddy-web-az2 10.0.11.0/24
             prod-lovedaddy-rds-az1 10.0.20.0/24
             prod-lovedaddy-rds-az2 10.0.21.0/24
```

# セキュリティグループ

```
prod-lovedaddy-alb-sg
インバウンド 443
ソース      0.0.0.0/0

prod-lovedaddy-ctrl-sg
インバウンド 22
ソース      0.0.0.0/0

prod-lovedaddy-rds-sg
インバウンド 3306
ソース      prod-lovedaddy-web-sg

prod-lovedaddy-web-sg
インバウンド 80
ソース      prod-lovedaddy-alb-sg
インバウンド 22
ソース      prod-lovedaddy-ctrl-sg
```

# RDS

サブネットグループ
```
Name: prod-lovedaddy-rds-subnet
      => prod-lovedaddy-rds-az1 10.0.20.0/24
      => prod-lovedaddy-rds-az2 10.0.21.0/24
```

Aurora MySQL5.7.12互換
```
Class:            db.t2.small
Multi-AZ:         Yes
識別子:            prod-lovedaddy
User:             lovedaddy
Password:         @see GoogleDrive
クラスター識別子:    prod-lovedaddy-clu
DB:               lovedaddy
暗号化:            無効
拡張モニタリング:    有効
マイナーアップデート: 有効
```

パラメータグループを作成して適用
```
prod-lovedaddy-params
prod-lovedaddy-params-clu
```

# ALB

```
Name: prod-lovedaddy-alb
プロトコル: 443
AZ:       prod-lovedaddy-alb-az1 10.0.1.0/24
          prod-lovedaddy-alb-az2 10.0.2.0/24

ACMで証明書作成と選択
既存のセキュリティーグループ: prod-lovedaddy-alb-sg

ターゲットグループ: prod-lovedaddy-alb-tg
プロトコル: 80
```

# ロールの作成

```
ロール名: prod-lovedaddy-role

アタッチされたポリシー
    AmazonS3FullAccess
```

# ユーザーの作成

```
ユーザー名: prod-lovedaddy-iam-user

アクセスキーおよびシークレットキー: @see GoogleDrive

プログラムによるアクセスにチェック

アタッチされたポリシー
    AmazonS3FullAccess
```

# EC2

Control-srv(セットアップは Ansible 参照)
```
Name:    prod-lovedaddy-ctrl
EIP:     54.238.230.145
キーペア: lovedaddy
削除保護: 有効
$ hostnamectl set-hostname prod-lovedaddy-ctrl
```

Web srv(セットアップは Ansible 参照)
```
Name:    prod-lovedaddy-web
キーペア: lovedaddy
削除保護: 有効
role: prod-lovedaddy-role
$ hostnamectl set-hostname prod-lovedaddy-web
```

# S3

```
バケット名: prod-lovedaddy
リージョン: 東京
```
