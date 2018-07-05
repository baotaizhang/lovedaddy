class UserOption < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :option
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
