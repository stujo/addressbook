json.array!(@phones) do |phone|
  json.extract! phone, :id, :phone_type, :digits, :contact_id
  json.url phone_url(phone, format: :json)
end
