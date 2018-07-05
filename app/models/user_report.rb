class UserReport < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :report_user, class_name: 'User'
  belongs_to :target_user, class_name: 'User'
  belongs_to :reason, class_name: 'UserReportReason'

  validates :reason, presence: true
  validates :detail_text, presence: true, length: {maximum: 10000}
end

# == Schema Information
#
# Table name: user_reports
#
#  id             :integer          not null, primary key
#  report_user_id :integer
#  target_user_id :integer
#  reason_id      :integer          not null
#  detail_text    :text(65535)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (report_user_id => users.id)
#  fk_rails_...  (target_user_id => users.id)
#
