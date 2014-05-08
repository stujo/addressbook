module AddressesHelper
  def address_types_for_select(address)
    options_for_select(Address.address_types.keys, selected: address.address_type)
  end
end
