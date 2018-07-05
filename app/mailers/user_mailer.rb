class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.reset_password_email.subject
  #   en.user_mailer.activation_needed_email.subject
  #   en.user_mailer.activation_success_email.subject
  #
  def reset_password_email(user)
    @user = User.find user.id
    @url  = edit_password_reset_url(@user.reset_password_token)
    mail(
      to: @user.email,
      subject: "【LoveDaddy】パスワード再設定のご案内"
    )
  end

  def activation_needed_email(user)
    @user = user
    @url  = activate_user_url(user.activation_token)
    mail(
      to: @user.email,
      subject: "【LoveDaddy】本登録のご案内"
    )
  end

  def activation_success_email(user)
    @user = user
    @url  = login_url
    mail(
      to: @user.email,
      subject: "【LoveDaddy】本登録完了のお知らせ"
    )
  end

  def birthday_credential_approved_email(user)
    @user = user
    @url = login_url
    mail(
      to: @user.email,
      subject: "【LoveDaddy】年齢証明完了のお知らせ"
    )
  end

  def income_credential_approved_email(user)
    @user = user
    @url = login_url
    mail(
      to: @user.email,
      subject: "【LoveDaddy】所得証明完了のお知らせ"
    )
  end
end
