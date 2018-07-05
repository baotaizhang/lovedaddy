class CreateUserOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :user_options, comment: 'ユーザーのオプション設定' do |t|
      t.references :user,      foreign_key: true, comment: '設定するユーザー'
      t.integer    :option_id, null: false,       comment: '設定するオプション'

      t.timestamps
    end
  end
end
