class Address < ActiveRecord::Base
  belongs_to :contact
  enum address_type: { :is_home => "0", :is_office => "1", :is_other => "2" }
  delegate :full_name, to: :contact

  def self.ransackable_attributes(auth_object = nil)
    [:street, :street_2, :city, :zip, :state]
  end

end
