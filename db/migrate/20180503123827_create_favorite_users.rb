class CreateFavoriteUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :favorite_users, comment: 'お気に入りユーザー' do |t|
      t.references :from_user, comment: 'お気に入りしたユーザー' 
      t.references :to_user, comment: 'お気に入りされたユーザー'

      t.timestamps
    end

    add_foreign_key :favorite_users, :users, column: :from_user_id
    add_foreign_key :favorite_users, :users, column: :to_user_id
  end
end
