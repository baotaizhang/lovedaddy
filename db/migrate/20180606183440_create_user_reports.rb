class CreateUserReports < ActiveRecord::Migration[5.2]
  def change
    create_table :user_reports, comment: '通報' do |t|
      t.references :report_user, index: true, foreign_key: {to_table: :users}, comment: '報告者'
      t.references :target_user, index: true, foreign_key: {to_table: :users}, comment: '通報対象者'
      t.integer    :reason_id,   null: false,                                  comment: '通報理由'
      t.text       :detail_text,                                               comment: '通報内容詳細'

      t.timestamps
    end
  end
end
