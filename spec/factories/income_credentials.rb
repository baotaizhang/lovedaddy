FactoryBot.define do
  factory :income_credential do
    user_id 1
    photo_1 "画像_1"
    photo_2 "画像_2"
    photo_3 "画像_3"
    status 1
  end
end

# == Schema Information
#
# Table name: income_credentials
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  photo_1    :string(255)
#  photo_2    :string(255)
#  photo_3    :string(255)
#  status     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
