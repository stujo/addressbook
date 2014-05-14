class Contact < ActiveRecord::Base

  GENDER_MALE = 1
  GENDER_FEMALE = 2

  scope :males, ->{ where(gender: GENDER_MALE ) }
  scope :females, ->{ where(gender: GENDER_FEMALE ) }

  validates_inclusion_of :gender, in: [nil, GENDER_MALE, GENDER_FEMALE], message: 'Please select either Male or Female'
  validates_presence_of :first_name, message: 'Please enter a name'

  has_many :addresses
  has_many :phones
  def full_name
    "#{first_name} #{last_name}"
  end

  accepts_nested_attributes_for :phones
  accepts_nested_attributes_for :addresses


  #
  # def self.ransackable_attributes(auth_object = nil)
  #   [:first_name, :last_name]
  # end
end
