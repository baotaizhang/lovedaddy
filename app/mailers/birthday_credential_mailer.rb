class BirthdayCredentialMailer < ApplicationMailer
  def to_operator(user, birthday_credential)
    @user = user
    @birthday_credential = birthday_credential

    mail(
      to: Settings.company.mail,
      subject: "【LoveDaddy】#{@user.nickname}さんの年齢証明画像がアップロードされました"
    )
  end
end
