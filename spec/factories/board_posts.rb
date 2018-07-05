FactoryBot.define do
  factory :board_post do
    user_id 1
    title "テスト投稿"
    content "募集内容"
    purpose 1
  end
end

# == Schema Information
#
# Table name: board_posts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  title      :string(255)      not null
#  content    :text(65535)      not null
#  purpose    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
