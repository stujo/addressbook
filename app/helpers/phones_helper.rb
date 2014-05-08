module PhonesHelper
  def phone_types_for_select(phone)
    options_for_select(Phone.phone_types.keys, selected: phone.phone_type)
  end
end
