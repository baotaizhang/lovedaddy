FactoryBot.define do
  factory :favorite_user do
    from_user 1
    to_user 2
  end
end

# == Schema Information
#
# Table name: favorite_users
#
#  id           :integer          not null, primary key
#  from_user_id :integer
#  to_user_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (from_user_id => users.id)
#  fk_rails_...  (to_user_id => users.id)
#
