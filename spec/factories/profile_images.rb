FactoryBot.define do
  factory :profile_image do
    user nil
    photo "MyString"
    status "MyString"
  end
end

# == Schema Information
#
# Table name: profile_images
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  photo      :string(255)
#  status     :integer          default("open")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
