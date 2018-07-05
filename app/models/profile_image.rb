class ProfileImage < ApplicationRecord
  extend Enumerize
  mount_uploader :photo, ProfileImageUploader

  MAX_NUM = 10.freeze

  belongs_to :user
  enumerize :status, in: { open: 0, viewable_user: 1 }, scope: true

  validates :photo, presence: true
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
