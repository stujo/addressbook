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
  item
end


if Object.const_get('Contact')

  zips = ['94012', '94032', '94103', '94102', '94010', '94101', '94321', '94523', '94112', '94113', '94132', '91432']
  cities = ['San Francisco', 'San Jose', 'Emeryville']
  streets = ['Main St', 'Market St', 'Harbor St', 'West St']

  address_types = [:is_office, :is_home, :is_other]

  first_names = ['Alan', 'Peter', 'Bob', 'John', 'Jane', 'Sarah', 'Sally', 'Julie', 'Catheine', 'Rebecca', 'Heather', 'Kat', 'Mary', 'Paula', 'Dana', 'Karla', 'Minnie', 'Marge']
  last_names = ['Jones', 'Smith', 'Williams', 'Evans', 'Tilly', 'Thompson', 'McDonald', 'White', 'Milford', 'Johnson', 'Green', 'Black', 'Simpson', 'Riley']

  birth_years = (1950..2000).to_a
  birth_months = (1..12).to_a
  birth_days = (1..28).to_a

  rnd_numbers = (1..100).to_a
  digits = (1000..6000).to_a
  areas = [415, 510, 650]

  first_names.each.with_index do |first_name, name_index|
    last_names.each do |last_name|

      gender = name_index < 4 ? Contact::GENDER_MALE : Contact::GENDER_FEMALE

      contact = Contact.find_or_create_by!({first_name: first_name, last_name: last_name, gender: gender, dob: Date.parse("#{birth_years.sample}-#{birth_months.sample}-#{birth_days.sample}")})

      (0..4).to_a.sample.times do
        add = {address_type: address_types.sample, street: "#{rnd_numbers.sample} #{streets.sample}", city: cities.sample, state: 'CA', zip: zips.sample, contact: contact};
        #make some with apt numbers
        add[:street_2] = "##{rnd_numbers.sample}" if rnd_numbers.sample > 60
        Address.find_or_create_by!(add)
      end
      (0..4).to_a.sample.times do
        Phone.find_or_create_by!({phone_type: address_types.sample, digits: "(#{areas.sample}) 555-#{digits.sample}", contact: contact})
      end
    end
  end


  bob = seeder Contact, :first_name, {first_name: 'Bob', gender: Contact::GENDER_MALE, last_name: 'Williams', dob: Date.parse('1980-02-03')}
  jane = seeder Contact, :first_name, {first_name: 'Jane', gender: Contact::GENDER_FEMALE, last_name: 'Smith', dob: Date.parse('1972-06-09')}
  walter = seeder Contact, :first_name, {first_name: 'Walter', gender: Contact::GENDER_MALE, last_name: 'White', dob: Date.parse('2001-07-05')}
  paula = seeder Contact, :first_name, {first_name: 'Paula', gender: Contact::GENDER_FEMALE, last_name: 'Jones', dob: Date.parse('1992-04-01')}
  will = seeder Contact, :first_name, {first_name: 'William', gender: Contact::GENDER_MALE, last_name: 'Hilson', dob: Date.parse('1967-04-13')}
  john = seeder Contact, :first_name, {first_name: 'John', gender: Contact::GENDER_MALE, last_name: 'Hammer', dob: Date.parse('1989-02-03')}
  karla = seeder Contact, :first_name, {first_name: 'Karla', gender: Contact::GENDER_FEMALE, last_name: 'Tillen', dob: Date.parse('1991-02-19')}

  Address.find_or_create_by!({address_type: :is_office, street: '100 Main', street_2: 'Suite 104', city: 'San Francisco', state: 'CA', zip: '94012', contact: bob})
  Address.find_or_create_by!({address_type: :is_office, street: '100 Main', street_2: 'Suite 101', city: 'San Francisco', state: 'CA', zip: '94012', contact: jane})
  Address.find_or_create_by!({address_type: :is_office, street: '100 Main', street_2: 'Suite 207', city: 'San Francisco', state: 'CA', zip: '94012', contact: walter})
  Address.find_or_create_by!({address_type: :is_other, street: '999 West', street_2: '#5', city: 'San Francisco', state: 'CA', zip: '94102', contact: walter})
  Address.find_or_create_by!({address_type: :is_home, street: '123 Appleton St', city: 'Boston', state: 'MA', zip: '02116', contact: paula})
  Phone.find_or_create_by!({phone_type: :is_office, digits: '(415) 555-7422', contact: bob})
  Phone.find_or_create_by!({phone_type: :is_office, digits: '(415) 555-9311', contact: jane})
  Phone.find_or_create_by!({phone_type: :is_office, digits: '(415) 555-6387', contact: walter})
  Phone.find_or_create_by!({phone_type: :is_other, digits: '(707) 555-1412', contact: walter})
  Phone.find_or_create_by!({phone_type: :is_home, digits: '(123) 555-6335', contact: paula})


  billy_phone_only = Contact.find_or_create_by!({first_name: 'Billy', last_name: 'Phone Only', gender: Contact::GENDER_MALE, dob: Date.parse("#{birth_years.sample}-#{birth_months.sample}-#{birth_days.sample}")})
  billy_address_only = Contact.find_or_create_by!({first_name: 'Billy', last_name: 'Address Only', gender: Contact::GENDER_MALE, dob: Date.parse("#{birth_years.sample}-#{birth_months.sample}-#{birth_days.sample}")})
  billy_both = Contact.find_or_create_by!({first_name: 'Billy', last_name: 'Both', gender: Contact::GENDER_MALE, dob: Date.parse("#{birth_years.sample}-#{birth_months.sample}-#{birth_days.sample}")})
  billy_none = Contact.find_or_create_by!({first_name: 'Billy', last_name: 'None', gender: Contact::GENDER_MALE, dob: Date.parse("#{birth_years.sample}-#{birth_months.sample}-#{birth_days.sample}")})

  Phone.find_or_create_by!({phone_type: :is_home, digits: '(123) 555-7777', contact: billy_phone_only})

  Phone.find_or_create_by!({phone_type: :is_home, digits: '(123) 555-8888', contact: billy_both})

  Address.find_or_create_by!({address_type: :is_other, street: '1000 East', city: 'San Francisco', state: 'CA', zip: '94102', contact: billy_address_only})

  Address.find_or_create_by!({address_type: :is_other, street: '414 South', city: 'Boston', state: 'MA', zip: '02123', contact: billy_address_only})

  Address.find_or_create_by!({address_type: :is_other, street: '1000 North', city: 'San Francisco', state: 'CA', zip: '94102', contact: billy_both})


end

