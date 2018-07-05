class CreateProfileImages < ActiveRecord::Migration[5.2]
  def change
    create_table :profile_images, comment: 'プロフィール画像' do |t|
      t.references :user,                comment: 'ユーザー'
      t.string     :photo,               comment: '画像'
      t.integer    :status, default: 0,  comment: '公開範囲'

      t.timestamps
    end

    add_foreign_key :profile_images, :users, column: :user_id
  end
end
