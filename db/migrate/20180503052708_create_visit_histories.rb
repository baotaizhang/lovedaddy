class CreateVisitHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :visit_histories, comment: '訪問履歴' do |t|
      t.references :from_user,     comment: '訪問したユーザー'
      t.references :to_user,       comment: '訪問されたユーザー'

      t.timestamps
    end

    add_foreign_key :visit_histories, :users, column: :from_user_id
    add_foreign_key :visit_histories, :users, column: :to_user_id
  end
end
