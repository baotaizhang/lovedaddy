class CreateImageViewableUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :image_viewable_users, comment: '閲覧許可ユーザー' do |t|
      t.references :set_user,           comment: '設定したユーザー'
      t.references :viewing_user,       comment: '閲覧許可されたユーザー'

      t.timestamps
    end

    add_foreign_key :image_viewable_users, :users, column: :set_user_id
    add_foreign_key :image_viewable_users, :users, column: :viewing_user_id
  end
end
