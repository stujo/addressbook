json.array!(@addresses) do |address|
  json.extract! address, :id, :address_type, :street, :street_2, :city, :state, :zip, :contact_id
  json.url address_url(address, format: :json)
end
