require 'rails_helper'

RSpec.describe BoardPost, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
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
