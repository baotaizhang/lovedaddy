FactoryBot.define do
  factory :message do
    from_user 1
    to_user 1
    content "テストメッセージ"
  end
end

# == Schema Information
#
# Table name: messages
#
#  id           :integer          not null, primary key
#  from_user_id :integer
#  to_user_id   :integer
#  content      :text(65535)
#  image        :text(65535)
#  opened_at    :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (from_user_id => users.id)
#  fk_rails_...  (to_user_id => users.id)
#
