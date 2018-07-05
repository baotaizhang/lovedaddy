class CreateDisplayUnsubscribeUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :display_unsubscribe_users, comment: '特定非表示ユーザー' do |t|
      t.references :from_user, comment: '設定した人'
      t.references :to_user,   comment: '設定された人'

      t.timestamps
    end

    add_foreign_key :display_unsubscribe_users , :users, column: :from_user_id
    add_foreign_key :display_unsubscribe_users , :users, column: :to_user_id
  end
end
