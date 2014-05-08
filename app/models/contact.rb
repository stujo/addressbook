class Contact < ActiveRecord::Base
  has_many :addresses
  has_many :phones
  def full_name
    "#{first_name} #{last_name}"
  end
end
