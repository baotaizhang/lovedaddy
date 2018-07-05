class BlockUser < ApplicationRecord
  belongs_to :set_user, class_name: 'User'
  belongs_to :blocked_user, class_name: 'User'

  validates :set_user_id, uniqueness: { scope: :blocked_user_id }
  validate :same_user?

  def same_user?
    errors.add(:blocked_user, "は自分にすることはできません") if set_user == blocked_user
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
