class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages, comment: 'メッセージ' do |t|
      t.references :from_user, comment: '送信ユーザー'
      t.references :to_user,   comment: '受信ユーザー'
      t.text       :content,   comment: 'メッセージ内容'
      t.text       :image,     comment: '送信画像'
      t.datetime   :opened_at, comment: '最新既読範囲フラグ'

      t.timestamps
    end

    add_foreign_key :messages, :users, column: :from_user_id
    add_foreign_key :messages, :users, column: :to_user_id
  end
end
