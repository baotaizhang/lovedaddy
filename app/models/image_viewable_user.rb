class ImageViewableUser < ApplicationRecord
  belongs_to :set_user, class_name: 'User'
  belongs_to :viewing_user, class_name: 'User'

  validates :set_user_id, uniqueness: {scope: :viewing_user_id}
end

# == Schema Information
#
# Table name: image_viewable_users
#
#  id              :integer          not null, primary key
#  set_user_id     :integer
#  viewing_user_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (set_user_id => users.id)
#  fk_rails_...  (viewing_user_id => users.id)
#
