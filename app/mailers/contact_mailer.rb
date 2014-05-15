class ContactMailer < ActionMailer::Base
  default from: ENV["GMAIL_USERNAME"]

  def send_message(message)
    @message = message
    mail(to: message.contact.email, subject: message.message_subject, )
  end
end
