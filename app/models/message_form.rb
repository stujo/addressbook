class MessageForm
  include ActiveModel::Model

  def self.messaging_enabled
    !(ENV["GMAIL_USERNAME"].blank? ||  ENV["GMAIL_PASSWORD"].blank?)
  end

  attr_accessor :message_subject
  attr_accessor :message_body
  attr_accessor :contact
  attr_reader :message_status

  validates_presence_of :contact, message: 'You must specify a recipient'
  validates_length_of :message_subject, minimum: 2, message: 'At least 2 letters'
  validates_length_of :message_body, minimum: 2, message: 'At least 2 letters'

  def persisted?
    false
  end

  def send_message
    @message_status = ContactMailer.send_message(self).deliver
  end
end
