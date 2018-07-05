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
stg-lovedaddy-vpc 192.168.0.0/16
```

Subnet
```
stg-lovedaddy-alb-az1 192.168.1.0/24
stg-lovedaddy-alb-az2 192.168.2.0/24
stg-lovedaddy-web-az1 192.168.10.0/24
stg-lovedaddy-web-az2 192.168.11.0/24
stg-lovedaddy-rds-az1 192.168.20.0/24
stg-lovedaddy-rds-az2 192.168.21.0/24
stg-lovedaddy-nat     192.168.30.0/24
stg-lovedaddy-ctrl    192.168.40.0/24
```

Internet GW
```
stg-lovedaddy-gw-public
VPC にアタッチ
```

NAT GW
```
stg-lovedaddy-gw-private
EIP 18.179.82.90
```

ルートテーブル
```
stg-lovedaddy-rtb-public
0.0.0.0/0 => stg-lovedaddy-gw-public
関連付け   => stg-lovedaddy-ctrl
             stg-lovedaddy-alb-az1
             stg-lovedaddy-alb-az2
             stg-lovedaddy-nat

stg-lovedaddy-rtb-private
0.0.0.0/0 => stg-lovedaddy-gw-private
関連付け   => stg-lovedaddy-web-az1 192.168.10.0/24
             stg-lovedaddy-web-az2 192.168.11.0/24
             stg-lovedaddy-rds-az1 192.168.20.0/24
             stg-lovedaddy-rds-az2 192.168.21.0/24
```


# セキュリティグループ

```
stg-lovedaddy-alb-sg
インバウンド 443
ソース      0.0.0.0/0

stg-lovedaddy-ctrl-sg
インバウンド 22
ソース      0.0.0.0/0

stg-lovedaddy-rds-sg
インバウンド 3306
ソース      stg-lovedaddy-web-sg

stg-lovedaddy-web-sg
インバウンド 80
ソース      stg-lovedaddy-alb-sg
インバウンド 22
ソース      stg-lovedaddy-ctrl-sg
```

# RDS

サブネットグループ
```
Name: stg-lovedaddy-rds-subnet
      => stg-lovedaddy-rds-az1 192.168.20.0/24
      => stg-lovedaddy-rds-az2 192.168.21.0/24
```

Aurora MySQL5.7.12互換
```
Class:            db.t2.small
Multi-AZ:         Yes
識別子:            stg-lovedaddy
User:             lovedaddy
Password:         @see GoogleDrive
クラスター識別子:    stg-lovedaddy-clu
DB:               lovedaddy
暗号化:            無効
拡張モニタリング:    無効
マイナーアップデート: 有効
```

パラメータグループを作成して適用
```
stg-lovedaddy-params
stg-lovedaddy-params-clu
```

# ALB

```
Name: stg-lovedaddy-alb
プロトコル: 443
AZ:       stg-lovedaddy-alb-az1 192.168.1.0/24
          stg-lovedaddy-alb-az2 192.168.2.0/24

ACMで証明書作成と選択: ワイルドカード版を作成して選択
既存のセキュリティーグループ: stg-lovedaddy-alb-sg

ターゲットグループ: stg-lovedaddy-alb-tg
プロトコル: 80
```

# ロールの作成

```
ロール名: stg-lovedaddy-role

アタッチされたポリシー
    AmazonS3FullAccess
```

# ユーザーの作成

```
ユーザー名: stg-lovedaddy-iam-user

アクセスキーおよびシークレットキー: @see GoogleDrive

プログラムによるアクセスにチェック

アタッチされたポリシー
    AmazonS3FullAccess
```

# EC2

Control-srv(セットアップは Ansible 参照)
```
Name:    stg-lovedaddy-ctrl
EIP:     52.199.22.188
キーペア: lovedaddy
削除保護: 有効
$ hostnamectl set-hostname stg-lovedaddy-ctrl
```

Web srv(セットアップは Ansible 参照)
```
Name:    stg-lovedaddy-web
キーペア: lovedaddy
削除保護: 有効
role: stg-lovedaddy-role
$ hostnamectl set-hostname stg-lovedaddy-web
```

# S3

```
バケット名: stg-lovedaddy
リージョン: 東京
```
