class Message < ApplicationRecord
  mount_uploader :image, MessageImageUploader
  attr_accessor :image_camera, :image_attachment

  belongs_to :from_user, class_name: 'User'
  belongs_to :to_user, class_name: 'User'

  scope :without_block_users, ->(current_user) { where.not(from_user_id: current_user.block_relations.pluck(:blocked_user_id)).where.not(to_user_id: current_user.block_relations.pluck(:blocked_user_id)) }

  validates :content, presence: true, length: {maximum: 5000}, unless: :image?

  before_validation do
    self.image = image_camera || image_attachment || nil
  end

  before_save do
    self.content = nil if image?
  end

  def to_param
    # 送信先に設定されている人とのメッセージ画面を開く（相手はpartner_userで取得すること）
    to_user.url_token.to_s
  end

  def partner_user(current_user)
    @partner_user ||= to_user == current_user ? from_user : to_user
  end

  def open!
    self.update_columns(opened_at: Time.current) if opened_at.nil?
  end

  def notifiable?
    unless to_user.has_option?(:message_mail) &&       # メール通知設定OFF
           to_user.block_users.exclude?(from_user) &&  # 送信先が送信元をブロック中
           to_user.last_logged_in_at < 3.seconds.ago   # 相手が3秒以内に活動なし
      return false 
    end

    prev_message = from_user.messages_with(to_user).where("id < ?", id).order(id: :desc).first
    # 直前のメッセージが相手から or 連続送信で5分以上の間隔
    prev_message.from_user == to_user || (prev_message.from_user == from_user && prev_message.created_at <= 5.minutes.ago)
  end
end

# == Schema Information
#
# Table name: messages
#
#  id           :integer          not null, primary key
#  from_user_id :integer
#  to_user_id   :integer
#  content      :text(65535)
#  image        :text(65535)
#  opened_at    :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (from_user_id => users.id)
#  fk_rails_...  (to_user_id => users.id)
#
