class ApplicationMailer < ActionMailer::Base
  default from: Settings.company.ses_mail
  layout 'mailer'
end
