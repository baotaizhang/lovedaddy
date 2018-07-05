class IncomeCredential < ApplicationRecord
  extend Enumerize
  mount_uploader :photo_1, IncomeCredentialUploader
  mount_uploader :photo_2, IncomeCredentialUploader
  mount_uploader :photo_3, IncomeCredentialUploader

  belongs_to :user
  enumerize :status, in: { approved: 1, waiting: 2, rejected: 3 }, scope: true

  validates :photo_1, presence: true
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
