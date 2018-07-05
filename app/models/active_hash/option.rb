class Option < ActiveHash::Base
  include ActiveHash::Associations
  has_many :user_options

  # 利用条件
  field :sex, default: nil
  field :birthday_credential, default: nil

  self.data = [
    {
      id: 1,
      code: :hide_online,
      name: 'オンライン表示を隠す',
      description: "有効にした場合オンライン表示がされず常に「最終ログイン3日前」の表示になります。",
      sex: 'male',
      birthday_credential: true
    },
    {
      id: 2,
      code: :hide_visit_history,
      name: '訪問履歴を残さない',
      description: "有効にした場合訪問したことが相手に分かりません。",
      sex: 'male',
      birthday_credential: true
    },
    {
      id: 3,
      code: :message_mail,
      name: 'メッセージの即時メール通知',
      description: '有効にした場合メッセージを受け取った場合にメールで通知されます。'
    }
  ]

  def showable?(user)
    self.sex.nil? || self.sex == user.sex
  end

  def usable?(user)
    (self.sex.nil? || self.sex == user.sex) &&
      (self.birthday_credential.nil? || user.birthday_credentials.with_status(:approved).present?)
  end

  def self.showable_options(user)
    showable_options = []
    Option.all.each do |option|
      showable_options << option if option.showable?(user)
    end
    showable_options
  end
end
