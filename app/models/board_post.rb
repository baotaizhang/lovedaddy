class BoardPost < ApplicationRecord
  extend Enumerize

  belongs_to :user
  enumerize :purpose, in: { message: 1, meet: 2, dinner: 3, free_day: 4 }

  validates :title,   presence: true, length: { maximum: 255 }
  validates :content, presence: true, length: { maximum: 10000 }
  validates :purpose, presence: true

end

# == Schema Information
#
# Table name: board_posts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  title      :string(255)      not null
#  content    :text(65535)      not null
#  purpose    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
