class BirthdayCredential < ApplicationRecord
  extend Enumerize
  mount_uploader :photo_1, BirthdayCredentialUploader
  mount_uploader :photo_2, BirthdayCredentialUploader
  mount_uploader :photo_3, BirthdayCredentialUploader

  belongs_to :user
  enumerize :status, in: { approved: 1, waiting: 2, rejected: 3 }, scope: true

  validates :photo_1, presence: true
end

# == Schema Information
#
# Table name: birthday_credentials
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
