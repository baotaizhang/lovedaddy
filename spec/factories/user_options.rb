FactoryBot.define do
  factory :user_option do
    user_id 1
    option_id 1
  end
end

# == Schema Information
#
# Table name: user_options
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  option_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
