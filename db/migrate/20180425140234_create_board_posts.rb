class CreateBoardPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :board_posts, comment: '掲示板投稿' do |t|
      t.references :user,    foreign_key: true, comment: '投稿者'
      t.string     :title,   null: false,       comment: 'タイトル'
      t.text       :content, null: false,       comment: '投稿内容'
      t.integer    :purpose, null: false,       comment: '目的'

      t.timestamps
    end
  end
end
