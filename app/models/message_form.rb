class MessageForm
  include ActiveModel::Model

  attr_accessor :message_subject
  attr_accessor :message_body
  attr_accessor :contact

  validates_presence_of :contact, message: 'You must specify a recipient'
  validates_length_of :message_subject, minimum: 2, message: 'At least 2 letters'
  validates_length_of :message_body, minimum: 2, message: 'At least 2 letters'

  def persisted?
    false
  end

  def send_message
    @errors.add(:message_subject, "Not Implemented Yet!")
  end
end
