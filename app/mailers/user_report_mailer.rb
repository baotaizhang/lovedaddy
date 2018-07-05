class UserReportMailer < ApplicationMailer
  def to_operator(user_report)
    @user_report = user_report

    mail(
      to: Settings.company.mail,
      subject: "【LoveDaddy通報】#{@user_report.target_user.nickname}/#{@user_report.reason.title}"
    )
  end
end
