class Contact < ApplicationRecord
  validates :title,   presence: true, length: {maximum: 255}
  validates :email,   presence: true, length: {maximum: 255}
  validates :content, presence: true, length: {maximum: 10000}
end

# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  email      :string(255)
#  content    :text(65535)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
