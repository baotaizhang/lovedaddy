class ContactMailer < ApplicationMailer

  def to_user(contact)
    @contact = contact

    mail(
      to: @contact.email,
      subject: "【LoveDaddy】お問合わせ有難うございました"
    )
  end

  def to_operator(contact)
    @contact = contact

    mail(
      to: Settings.company.mail,
      subject: "【LoveDaddy】問い合わせ：#{@contact.title}"
    )
  end
end
