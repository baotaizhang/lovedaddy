class CreateIncomeCredentials < ActiveRecord::Migration[5.2]
  def change
    create_table :income_credentials, comment: '収入証明' do |t|
      t.references :user, foreign_key: true, comment: 'ユーザー'
      t.string     :photo_1,                 comment: '画像_1'
      t.string     :photo_2,                 comment: '画像_2'
      t.string     :photo_3,                 comment: '画像_3'
      t.integer    :status, null: false,     comment: '承認ステータス'

      t.timestamps
    end
  end
end
