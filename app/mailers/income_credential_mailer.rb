class IncomeCredentialMailer < ApplicationMailer
  def to_operator(user, income_credential)
    @user = user
    @income_credential = income_credential

    mail(
      to: Settings.company.mail,
      subject: "【LoveDaddy】#{@user.nickname}さんの所得証明画像がアップロードされました"
    )
  end
end
