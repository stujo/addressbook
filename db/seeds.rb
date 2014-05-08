# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


def seeder model, key, data
  item = model.where({key => data[key]}).first
  if item.nil?
    puts "Seeding #{model.name} #{data[key]}"
    item = model.create(data)
  end
end


if Object.const_get('Contact')
  bob = seeder Contact, :first_name, {first_name: 'Bob', last_name: 'Williams', dob: Date.parse('1980-02-03')}
  jane = seeder Contact, :first_name, {first_name: 'Jane', last_name: 'Smith', dob: Date.parse('1980-02-03')}
  walter = seeder Contact, :first_name, {first_name: 'Walter', last_name: 'White', dob: Date.parse('1980-02-03')}
  paula = seeder Contact, :first_name, {first_name: 'Paula', last_name: 'Jones', dob: Date.parse('1980-02-03')}

  if Object.const_get('Address')
    Address.find_or_create_by!({address_type: :is_office, street: '100 Main', street_2: 'Suite 104', city: 'San Francisco', state: 'CA', zip: '94012', contact: bob})
    Address.find_or_create_by!({address_type: :is_office, street: '100 Main', street_2: 'Suite 101', city: 'San Francisco', state: 'CA', zip: '94012', contact: jane})
    Address.find_or_create_by!({address_type: :is_office, street: '100 Main', street_2: 'Suite 207', city: 'San Francisco', state: 'CA', zip: '94012', contact: walter})
    Address.find_or_create_by!({address_type: :is_other, street: '999 West', street_2: '#5', city: 'San Francisco', state: 'CA', zip: '94102', contact: walter})
    Address.find_or_create_by!({address_type: :is_home, street: '123 Appleton St', city: 'Boston', state: 'MA', zip: '02116', contact: paula})
  end

  if Object.const_get('Phone')
    Phone.find_or_create_by!({phone_type: :is_office, digits: '(415) 555-7422', contact: bob})
    Phone.find_or_create_by!({phone_type: :is_office, digits: '(415) 555-9311', contact: jane})
    Phone.find_or_create_by!({phone_type: :is_office, digits: '(415) 555-6387', contact: walter})
    Phone.find_or_create_by!({phone_type: :is_other, digits: '(707) 555-1412', contact: walter})
    Phone.find_or_create_by!({phone_type: :is_home, digits: '(123) 555-6335', contact: paula})
  end

end

