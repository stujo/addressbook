module ContactsHelper

  def contacts_for_select
    Contact.all.collect { |m| [m.full_name, m.id] }
  end

  def contact_gender_display contact
    if contact.gender == Contact::GENDER_MALE
      'Male'
    elsif contact.gender == Contact::GENDER_FEMALE
      'Female'
    end
  end

  def contact_card_class contact
    if contact.gender == Contact::GENDER_MALE
      'addressbook-male'
    elsif contact.gender == Contact::GENDER_FEMALE
      'addressbook-female'
    end
  end
end
