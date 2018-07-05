class CreateBlockUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :block_users, comment: 'ブロックユーザー' do |t|
      t.references :set_user,     index: true, foreign_key: {to_table: :users}, comment: 'ブロックしたユーザー'
      t.references :blocked_user, index: true, foreign_key: {to_table: :users}, comment: 'ブロックされたユーザー'

      t.timestamps
    end
  end
end
