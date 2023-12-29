class CitizenMailer < ApplicationMailer
  default from: "no-reply@aws.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.citizen_mailer.registration_notification.subject
  #
  def registration_notification(citizen_full_name, citizen_email)
    @name = citizen_full_name.split.first

    mail(to: citizen_email, subject: 'Registo de munícipe')
  end
end
