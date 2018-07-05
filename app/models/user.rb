class User < ApplicationRecord
  authenticates_with_sorcery!
  extend ActiveHash::Associations::ActiveRecordExtensions
  extend Enumerize

  RANGE_HEIGHT   = [0, 130, 135, 140, 145, 150, 155, 160, 165, 170, 175, 180].freeze # cm
  RANGE_INCOME   = [0, 400, 600, 700, 800, 900, 1000, 1200, 1400, 1600, 1800, 2000, 2500, 3000, 4000, 5000, 6000, 7000, 8000, 9000, 10000].freeze # 万円
  RANGE_PROPERTY = [0, 1000, 3000, 5000, 7000, 9000, 10000, 30000, 50000, 100000].freeze # 万円

  enumerize :sex,        in: { male: 1, female: 2 }, scope: true
  enumerize :marital_relationship, in: { single: 1, married: 2 }, scope: true
  enumerize :motivation, in: { lunch: 1, start_with_meeting: 2, needs_matching: 3, glad_having_invitation: 4, having_invitation: 5 }
  enumerize :body_shape, in: { thin: 1, little_thin: 2, normal: 3, little_thick: 4, thick: 5 }, scope: true
  enumerize :drinking,   in: { no: 1, sometime: 2, yes: 3 }, scope: true
  enumerize :smoking,    in: { no: 1, sometime: 2, yes: 3 }, scope: true
  enumerize :occupation, in: { manager_big: 1, manager_middle: 2, practitioner: 3, government_official: 4, tokyo_stock: 5, manager_small: 43, investor: 6, doctor: 7, dentist: 8, lawyer: 9, accountant: 10, pilot: 11, flight_attendant: 12, model: 13, announcer: 14, big_company: 15, trading_company: 16, foreign_finance: 17, foreign_investment_consultation: 18, foreign_manufacturer: 19, judicial_scrivener: 20, administrative_scrivener: 21, local_public_servant: 22, media: 23, creator: 24, it: 25, architecture: 26, teacher: 27, sport: 28, event_companion: 29, receptionist: 30, secretary: 31, apparel: 32, aestheticians: 33, hairdresser: 34, pharmacist: 35, nurse: 36, cooks: 37, childminder: 38, bridal: 39, clerical_work: 40, employee: 41, student: 42} # next 44
  enumerize :role,       in: { general: 1, admin: 2 }, scope: true

  # プロフィール画像
  # メイン画像は User テーブルに保存
  mount_uploader :main_profile_image, ProfileImageUploader

  # サブ画像は ProfileImage テーブルに保存
  has_many :profile_images, dependent: :destroy, inverse_of: :user
  accepts_nested_attributes_for :profile_images, allow_destroy: true, reject_if: proc { |attributes| attributes['photo'].blank? && attributes['id'].blank? }

  # プロフィール画像の閲覧許可
  has_many :image_viewable_relations, class_name: 'ImageViewableUser', foreign_key: :set_user_id, dependent: :destroy
  has_many :image_viewable_users, through: :image_viewable_relations, source: :viewing_user
  has_many :reverse_image_viewable_relations, class_name: 'ImageViewableUser', foreign_key: :viewing_user_id, dependent: :destroy
  has_many :image_viewable_seters, through: :reverse_image_viewable_relations, source: :set_user

  # 訪問履歴
  has_many :came_histories, class_name: 'VisitHistory', foreign_key: :to_user_id, dependent: :destroy
  has_many :came_users, through: :came_histories, source: :from_user
  has_many :went_histories, class_name: 'VisitHistory', foreign_key: :from_user_id, dependent: :destroy
  has_many :went_users, through: :went_histories, source: :to_user

  # お気に入り
  has_many :reverse_favorite_relations, class_name: 'FavoriteUser', foreign_key: :to_user_id, dependent: :destroy
  has_many :reverse_favorite_users, through: :reverse_favorite_relations, source: :from_user
  has_many :favorite_relations, class_name: 'FavoriteUser', foreign_key: :from_user_id, dependent: :destroy
  has_many :favorite_users, through: :favorite_relations, source: :to_user

  # ブロック
  has_many :reverse_block_relations, class_name: 'BlockUser', foreign_key: :blocked_user_id, dependent: :destroy
  has_many :reverse_block_users, through: :reverse_block_relations, source: :set_user
  has_many :block_relations, class_name: 'BlockUser', foreign_key: :set_user_id, dependent: :destroy
  has_many :block_users, through: :block_relations, source: :blocked_user

  # 特定非表示
  has_many :reverse_display_unsubscribe_relations, class_name: 'DisplayUnsubscribeUser', foreign_key: :to_user_id, dependent: :destroy
  has_many :reverse_display_unsubscribe_users, through: :reverse_block_relations, source: :from_user
  has_many :display_unsubscribe_relations, class_name: 'DisplayUnsubscribeUser', foreign_key: :from_user_id, dependent: :destroy
  has_many :display_unsubscribe_users, through: :display_unsubscribe_relations, source: :to_user

  # 掲示板
  has_many :board_posts, dependent: :destroy

  # メッセージ
  has_many :receive_messages, class_name: 'Message', foreign_key: :to_user_id, dependent: :destroy
  has_many :receive_message_users, through: :receive_messages, source: :from_user
  has_many :send_messages, class_name: 'Message', foreign_key: :from_user_id, dependent: :destroy
  has_many :send_message_users, through: :send_messages, source: :to_user

  # 年齢証明
  has_many :birthday_credentials, dependent: :destroy

  # 所得証明
  has_many :income_credentials, dependent: :destroy

  # 設定（ActiveHashではActiveRecord::Relationが使用不可）
  has_many :user_options, dependent: :destroy

  scope :active, -> { where(deleted_at: nil) }

  def options
    user_options.map(&:option)
  end

  # プロフィール
  belongs_to :residence,  class_name: 'Prefecture'
  belongs_to :birthplace, class_name: 'Prefecture'

  # 通報
  has_many :reports, dependent: :destroy, class_name: 'UserReport', foreign_key: :report_user
  has_many :report_targets, through: :reports, source: :target_user
  has_many :targeted_reports, dependent: :destroy, class_name: 'UserReport', foreign_key: :target_user
  has_many :targeted_reporters, through: :reports, source: :report_user

  validates :email, presence: true, uniqueness: true

  with_options allow_nil: true do
    validates :height,   inclusion: { in: RANGE_HEIGHT }
    validates :income,   inclusion: { in: RANGE_INCOME }
    validates :property, inclusion: { in: RANGE_PROPERTY }
  end

  with_options on: :initial_update do
    validates :nickname, presence: true, format: { without: /\s/ }, uniqueness: true
    validates :sex, presence: true
    validates :birthday, presence: true
    validates :residence_id, presence: true
    validates :password, presence: true, length: { minimum: 6 }
  end

  with_options on: :crypted_password_changed? do
    validates :password, presence: true, length: { minimum: 6 }
  end

  before_save do
    self.url_token ||= uniq_url_token
  end

  def to_param
    url_token
  end

  # 閲覧者に公開する範囲のプロフィール画像を取得
  def profile_images_for(current_user)
    if image_viewable_users.include?(current_user) || self == current_user
      profile_images
    else
      profile_images.with_status(:open)
    end
  end

  def initialized?
    nickname? && sex? && birthday?
  end

  # 退会表示条件の判定
  def display_deleted?(current_user)
    deleted_at.present? || display_unsubscribe_users.include?(current_user)
  end

  def has_option?(code)
    options.find{|option| option.code == code.to_sym}.present?
  end

  # やりとりしたことのあるユーザー
  def message_users
    User.where(id: send_message_users.ids + receive_message_users.ids)
  end

  # 該当ユーザーとのやり取りを既読にする
  def message_open_with!(user)
    return false if self == user
    last_receive_message = receive_messages_with(user).last
    last_receive_message.open! if last_receive_message.present?
  end

  def logical_destroy!
    self.update! deleted_at: Time.current unless deleted_at?
  end

  # 該当ユーザーから受け取ったメッセージ
  def receive_messages_with(user)
    receive_messages.where(from_user: user)
  end

  # 該当ユーザーへ送ったメッセージ
  def send_messages_with(user)
    send_messages.where(to_user: user)
  end

  # 該当ユーザーとの送受信メッセージ
  def messages_with(user)
    receive_messages_with(user).or(send_messages_with(user))
  end

  # ユーザーごとに最新の送受信メッセージを取得
  def each_user_latest_messages
    messages = self.receive_messages.or(self.send_messages).includes(:to_user, :from_user)
    message_with_partner_ids = messages.map {|m| {id: m.id, partner_id: m.partner_user(self).id}}
    target_messages = message_with_partner_ids.group_by{|m| m[:partner_id]}.map do |partner_id, message|
      message.max_by{|m| m[:id]}
    end

    Message.where(id: target_messages.pluck(:id))
  end

  # ユーザーごとに最新の送信メッセージを取得
  def send_each_user_latest_messages
    Message.where(id: self.send_messages.group(:to_user_id).select('MAX(id)'))
  end

  # ユーザーごとに最新の受信メッセージを取得
  def receive_each_user_latest_messages
    Message.where(id: self.receive_messages.group(:from_user_id).select('MAX(id)'))
  end

  # 設定中のレンジ表示
  def range_text(column)
    params = User.range_culc_params(column)
    params[:num] = self.try(column)
    params[:num].nil? ? '未設定' : User.culc_range_text(params)
  end

  # 選択可能のレンジ表示一覧
  def self.select_range_list(column)
    params = range_culc_params(column)
    culc_range_list(params).zip(params[:range_const])
  end

  # Ransackフォーム用に名前とidのペアを取得
  def self.enumrizer_to_ransack(column)
    column = column.to_sym
    self.try(column).options.map do |option|
      locale_name, text_value = option
      [locale_name, self.try(column).find_value(text_value.to_sym).value]
    end
  end

  # 年齢証明の承認ステータス(審査中)
  def birthday_credential_waiting?
    self.birthday_credentials.present? && self.birthday_credentials.last.status.waiting?
  end

  # 所得証明の承認ステータス(承認済み)
  def income_credential_approved?
    self.income_credentials.present? && self.income_credentials.last.status.approved?
  end

  # 所得証明の承認ステータス(審査中)
  def income_credential_waiting?
    self.income_credentials.present? && self.income_credentials.last.status.waiting?
  end

  private

    def uniq_url_token
      loop do
        tmp_url_token = SecureRandom.urlsafe_base64
        return tmp_url_token unless User.find_by(url_token: tmp_url_token)
      end
    end

    def self.range_culc_params(column)
      case column.to_sym
      when :height
        {range_const: RANGE_HEIGHT,   prefixs: ['cm']}
      when :income
        {range_const: RANGE_INCOME,   prefixs: ['万円', '億円'], increase: 4, round: true}
      when :property
        {range_const: RANGE_PROPERTY, prefixs: ['万円', '億円'], increase: 4, round: true}
      else
        raise '未対応のrangeです'
      end
    end

    def self.culc_range_list(range_const:, prefixs:, increase: nil, round: false)
      prefixs = [prefixs] unless prefixs.kind_of?(Array)
      range_const.map do |num|
        culc_range_text(range_const: range_const, num: num, prefixs: prefixs, increase: increase, round: round)
      end
    end

    def self.culc_range_text(range_const:, num:, prefixs:, increase: nil, round: false)
      index = range_const.index(num)
      case index
      when nil
      when 0
        word = round ? '以下' : '未満'
        "#{increase_num_and_pref(range_const.second, prefixs, increase)}#{word}"
      when range_const.length - 1
        "#{increase_num_and_pref(range_const.last, prefixs, increase)}以上"
      else
        num = round ? 0 : -1
        "#{increase_num(range_const[index], increase)}〜#{increase_num_and_pref(range_const[index+1]+num, prefixs, increase)}"
      end
    end

    def self.increase_num_and_pref(num, prefixs, increase)
      increase_num(num, increase) + increase_prefixs(num, prefixs, increase)
    end

    def self.increase_prefixs(num, prefixs, increase)
      index = increase ? (num.to_s.length / (increase+1)) : 0
      prefixs[index]
    end

    def self.increase_num(num, increase)
      if increase
        up_times = num.to_s.length / (increase+1)
        delete_num = up_times * increase
        num.to_s.gsub(/.{#{delete_num}}$/, "")
      else
        num.to_s
      end
    end
end

# == Schema Information
#
# Table name: users
#
#  id                              :integer          not null, primary key
#  email                           :string(255)      default(""), not null
#  crypted_password                :string(255)      default(""), not null
#  salt                            :string(255)      default(""), not null
#  url_token                       :string(255)      not null
#  reset_password_token            :string(255)
#  reset_password_token_expires_at :datetime
#  reset_password_email_sent_at    :datetime
#  remember_me_token               :string(255)
#  remember_me_token_expires_at    :datetime
#  activation_state                :string(255)
#  activation_token                :string(255)
#  activation_token_expires_at     :datetime
#  sex                             :integer
#  nickname                        :string(255)
#  birthday                        :date
#  birthplace_id                   :integer
#  residence_id                    :integer
#  height                          :integer
#  body_shape                      :integer
#  drinking                        :integer
#  smoking                         :integer
#  marital_relationship            :integer
#  motivation                      :integer
#  occupation                      :integer
#  income                          :integer
#  property                        :integer
#  role                            :integer          default("general")
#  introduction                    :text(65535)
#  last_logged_in_at               :datetime
#  main_profile_image              :string(255)
#  deleted_at                      :datetime
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  failed_logins_count             :integer          default(0)
#  lock_expires_at                 :datetime
#  unlock_token                    :string(255)
#
