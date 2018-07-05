class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, comment: 'ユーザー' do |t|
      t.string   :email,            null: false, default: "", comment: 'メールアドレス'
      t.string   :crypted_password, null: false, default: "", comment: '暗号化済みパスワード'
      t.string   :salt,             null: false, default: "", comment: 'ソルト'
      t.string   :url_token,        null: false,              comment: 'アクセス用のURLトークン'
      t.string   :reset_password_token,                       comment: 'リセットパスワードトークン'
      t.datetime :reset_password_token_expires_at,            comment: 'リセットパスワードトークン有効日時'
      t.datetime :reset_password_email_sent_at,               comment: 'リセットパスワードメール送信日時'
      t.string   :remember_me_token,                          comment: 'リメンバーミートークン'
      t.datetime :remember_me_token_expires_at,               comment: 'リメンバーミートークン有効日時'
      t.string   :activation_state,            default: nil,  comment: 'アクティベーション状態'
      t.string   :activation_token,            default: nil,  comment: 'アクティベーショントークン'
      t.datetime :activation_token_expires_at, default: nil,  comment: 'アクティベーショントークン有効日時'
      t.integer  :sex,                                        comment: '性別'
      t.string   :nickname,                                   comment: 'ニックネーム'
      t.date     :birthday,                                   comment: '生年月日'
      t.integer  :birthplace_id,                              comment: '出身地'
      t.integer  :residence_id,                               comment: '居住地'
      t.integer  :height,                                     comment: '身長'
      t.integer  :body_shape,                                 comment: '体型'
      t.integer  :drinking,                                   comment: '飲酒'
      t.integer  :smoking,                                    comment: '喫煙'
      t.integer  :marital_relationship,                       comment: '婚姻関係'
      t.integer  :motivation,                                 comment: '交際タイプ'
      t.integer  :occupation,                                 comment: '職業'
      t.integer  :income,                                     comment: '年収'
      t.integer  :property,                                   comment: '資産'
      t.integer  :role,                        default: 1,    comment: '権限管理用ロール'
      t.text     :introduction,                               comment: '自己紹介'
      t.datetime :last_logged_in_at,                          comment: '最終ログイン日時'
      t.string   :main_profile_image,                         comment: 'メインプロフィール画像'
      t.datetime :deleted_at,                                 comment: '退会日時'

      t.timestamps
    end

    add_index :users, :url_token, unique: true
    add_index :users, :email, unique: true
    add_index :users, :activation_token
    add_index :users, :deleted_at
  end
end
