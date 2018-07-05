class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts, comment: '問い合わせ' do |t|
      t.string :title,              comment: 'タイトル'
      t.string :email,              comment: 'メール'
      t.text :content, null: false, comment: '本文'

      t.timestamps
    end
  end
end
