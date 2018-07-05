class NotificationMailer < ApplicationMailer

  def receive_message(message)
    @message = message

    mail(
      to: @message.to_user.email,
      subject: "【LoveDaddy】#{@message.from_user.nickname}さんからメッセージを受け取りました"
    )
  end
end
