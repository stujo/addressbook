class Contact < ActiveRecord::Base

  GENDER_MALE = 1
  GENDER_FEMALE = 2

  scope :males, ->{ where(gender: GENDER_MALE ) }
  scope :females, ->{ where(gender: GENDER_FEMALE ) }

  validates :gender, inclusion: { in: [GENDER_MALE, GENDER_FEMALE] }

  has_many :addresses
  has_many :phones
  def full_name
    "#{first_name} #{last_name}"
  end
end
