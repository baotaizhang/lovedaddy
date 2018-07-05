# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_06_24_142646) do

  create_table "birthday_credentials", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "本人証明", force: :cascade do |t|
    t.bigint "user_id", comment: "ユーザー"
    t.string "photo_1", comment: "画像_1"
    t.string "photo_2", comment: "画像_2"
    t.string "photo_3", comment: "画像_3"
    t.integer "status", null: false, comment: "承認ステータス"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_birthday_credentials_on_user_id"
  end

  create_table "block_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "ブロックユーザー", force: :cascade do |t|
    t.bigint "set_user_id", comment: "ブロックしたユーザー"
    t.bigint "blocked_user_id", comment: "ブロックされたユーザー"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blocked_user_id"], name: "index_block_users_on_blocked_user_id"
    t.index ["set_user_id"], name: "index_block_users_on_set_user_id"
  end

  create_table "board_posts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "掲示板投稿", force: :cascade do |t|
    t.bigint "user_id", comment: "投稿者"
    t.string "title", null: false, comment: "タイトル"
    t.text "content", null: false, comment: "投稿内容"
    t.integer "purpose", null: false, comment: "目的"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_board_posts_on_user_id"
  end

  create_table "contacts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "問い合わせ", force: :cascade do |t|
    t.string "title", comment: "タイトル"
    t.string "email", comment: "メール"
    t.text "content", null: false, comment: "本文"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "display_unsubscribe_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "特定非表示ユーザー", force: :cascade do |t|
    t.bigint "from_user_id", comment: "設定した人"
    t.bigint "to_user_id", comment: "設定された人"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["from_user_id"], name: "index_display_unsubscribe_users_on_from_user_id"
    t.index ["to_user_id"], name: "index_display_unsubscribe_users_on_to_user_id"
  end

  create_table "favorite_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "お気に入りユーザー", force: :cascade do |t|
    t.bigint "from_user_id", comment: "お気に入りしたユーザー"
    t.bigint "to_user_id", comment: "お気に入りされたユーザー"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["from_user_id"], name: "index_favorite_users_on_from_user_id"
    t.index ["to_user_id"], name: "index_favorite_users_on_to_user_id"
  end

  create_table "image_viewable_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "閲覧許可ユーザー", force: :cascade do |t|
    t.bigint "set_user_id", comment: "設定したユーザー"
    t.bigint "viewing_user_id", comment: "閲覧許可されたユーザー"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["set_user_id"], name: "index_image_viewable_users_on_set_user_id"
    t.index ["viewing_user_id"], name: "index_image_viewable_users_on_viewing_user_id"
  end

  create_table "income_credentials", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "収入証明", force: :cascade do |t|
    t.bigint "user_id", comment: "ユーザー"
    t.string "photo_1", comment: "画像_1"
    t.string "photo_2", comment: "画像_2"
    t.string "photo_3", comment: "画像_3"
    t.integer "status", null: false, comment: "承認ステータス"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_income_credentials_on_user_id"
  end

  create_table "messages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "メッセージ", force: :cascade do |t|
    t.bigint "from_user_id", comment: "送信ユーザー"
    t.bigint "to_user_id", comment: "受信ユーザー"
    t.text "content", comment: "メッセージ内容"
    t.text "image", comment: "送信画像"
    t.datetime "opened_at", comment: "最新既読範囲フラグ"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["from_user_id"], name: "index_messages_on_from_user_id"
    t.index ["to_user_id"], name: "index_messages_on_to_user_id"
  end

  create_table "profile_images", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "プロフィール画像", force: :cascade do |t|
    t.bigint "user_id", comment: "ユーザー"
    t.string "photo", comment: "画像"
    t.integer "status", default: 0, comment: "公開範囲"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profile_images_on_user_id"
  end

  create_table "user_options", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "ユーザーのオプション設定", force: :cascade do |t|
    t.bigint "user_id", comment: "設定するユーザー"
    t.integer "option_id", null: false, comment: "設定するオプション"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_options_on_user_id"
  end

  create_table "user_reports", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "通報", force: :cascade do |t|
    t.bigint "report_user_id", comment: "報告者"
    t.bigint "target_user_id", comment: "通報対象者"
    t.integer "reason_id", null: false, comment: "通報理由"
    t.text "detail_text", comment: "通報内容詳細"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["report_user_id"], name: "index_user_reports_on_report_user_id"
    t.index ["target_user_id"], name: "index_user_reports_on_target_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "ユーザー", force: :cascade do |t|
    t.string "email", default: "", null: false, comment: "メールアドレス"
    t.string "crypted_password", default: "", null: false, comment: "暗号化済みパスワード"
    t.string "salt", default: "", null: false, comment: "ソルト"
    t.string "url_token", null: false, comment: "アクセス用のURLトークン"
    t.string "reset_password_token", comment: "リセットパスワードトークン"
    t.datetime "reset_password_token_expires_at", comment: "リセットパスワードトークン有効日時"
    t.datetime "reset_password_email_sent_at", comment: "リセットパスワードメール送信日時"
    t.string "remember_me_token", comment: "リメンバーミートークン"
    t.datetime "remember_me_token_expires_at", comment: "リメンバーミートークン有効日時"
    t.string "activation_state", comment: "アクティベーション状態"
    t.string "activation_token", comment: "アクティベーショントークン"
    t.datetime "activation_token_expires_at", comment: "アクティベーショントークン有効日時"
    t.integer "sex", comment: "性別"
    t.string "nickname", comment: "ニックネーム"
    t.date "birthday", comment: "生年月日"
    t.integer "birthplace_id", comment: "出身地"
    t.integer "residence_id", comment: "居住地"
    t.integer "height", comment: "身長"
    t.integer "body_shape", comment: "体型"
    t.integer "drinking", comment: "飲酒"
    t.integer "smoking", comment: "喫煙"
    t.integer "marital_relationship", comment: "婚姻関係"
    t.integer "motivation", comment: "交際タイプ"
    t.integer "occupation", comment: "職業"
    t.integer "income", comment: "年収"
    t.integer "property", comment: "資産"
    t.integer "role", default: 1, comment: "権限管理用ロール"
    t.text "introduction", comment: "自己紹介"
    t.datetime "last_logged_in_at", comment: "最終ログイン日時"
    t.string "main_profile_image", comment: "メインプロフィール画像"
    t.datetime "deleted_at", comment: "退会日時"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "failed_logins_count", default: 0, comment: "ログイン失敗回数"
    t.datetime "lock_expires_at", comment: "アカウントロック有効期限"
    t.string "unlock_token", comment: "アンロックトークン"
    t.index ["activation_token"], name: "index_users_on_activation_token"
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["url_token"], name: "index_users_on_url_token", unique: true
  end

  create_table "visit_histories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "訪問履歴", force: :cascade do |t|
    t.bigint "from_user_id", comment: "訪問したユーザー"
    t.bigint "to_user_id", comment: "訪問されたユーザー"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["from_user_id"], name: "index_visit_histories_on_from_user_id"
    t.index ["to_user_id"], name: "index_visit_histories_on_to_user_id"
  end

  add_foreign_key "birthday_credentials", "users"
  add_foreign_key "block_users", "users", column: "blocked_user_id"
  add_foreign_key "block_users", "users", column: "set_user_id"
  add_foreign_key "board_posts", "users"
  add_foreign_key "display_unsubscribe_users", "users", column: "from_user_id"
  add_foreign_key "display_unsubscribe_users", "users", column: "to_user_id"
  add_foreign_key "favorite_users", "users", column: "from_user_id"
  add_foreign_key "favorite_users", "users", column: "to_user_id"
  add_foreign_key "image_viewable_users", "users", column: "set_user_id"
  add_foreign_key "image_viewable_users", "users", column: "viewing_user_id"
  add_foreign_key "income_credentials", "users"
  add_foreign_key "messages", "users", column: "from_user_id"
  add_foreign_key "messages", "users", column: "to_user_id"
  add_foreign_key "profile_images", "users"
  add_foreign_key "user_options", "users"
  add_foreign_key "user_reports", "users", column: "report_user_id"
  add_foreign_key "user_reports", "users", column: "target_user_id"
  add_foreign_key "visit_histories", "users", column: "from_user_id"
  add_foreign_key "visit_histories", "users", column: "to_user_id"
end
