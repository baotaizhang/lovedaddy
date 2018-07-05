class VisitHistory < ApplicationRecord
  belongs_to :from_user, class_name: 'User'
  belongs_to :to_user, class_name: 'User'
end

# == Schema Information
#
# Table name: visit_histories
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
