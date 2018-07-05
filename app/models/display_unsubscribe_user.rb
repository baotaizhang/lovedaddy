class DisplayUnsubscribeUser < ApplicationRecord
  belongs_to :from_user, class_name: 'User'
  belongs_to :to_user, class_name: 'User'

  validates :from_user_id, uniqueness: { scope: :to_user_id }
  validate :same_user?

  def same_user?
    errors.add(:to_user, "は自分にすることはできません") if from_user == to_user
  end
end

# == Schema Information
#
# Table name: display_unsubscribe_users
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
