class ContactMailer < ActionMailer::Base
  default from: ENV["GMAIL_USERNAME"]

  def send_message(message)
    @message = message
    mail(to: message.email, subject: message.subject)
  end
end
