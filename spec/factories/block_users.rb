FactoryBot.define do
  factory :block_user do
    set_user 1
    blocked_user 1
  end
end

# == Schema Information
#
# Table name: block_users
#
#  id              :integer          not null, primary key
#  set_user_id     :integer
#  blocked_user_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (blocked_user_id => users.id)
#  fk_rails_...  (set_user_id => users.id)
#
